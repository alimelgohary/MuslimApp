import 'package:flutter/material.dart';
import 'package:muslimapp/prayer/cityservice.dart';
import 'package:muslimapp/prayer/prayerscreen.dart';
import 'package:muslimapp/utils.dart';
import 'package:muslimapp/screens/homescreen.dart';
import 'package:sqflite/sqflite.dart';
import '../widgets.dart';
import 'countryservice.dart';
import 'methodservice.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  List<DropdownMenuItem<String>> dropCountries = [];
  List<DropdownMenuItem<String>> dropCities = [];
  List<DropdownMenuItem<int>> dropMethods = [];

  var countrySelected;
  var citySelected;
  var methodSelected;

  var configExistsBool;

  void getLists() async {
    configExistsBool = await configExists();
    print(configExistsBool);
    if (!configExistsBool) {
      dropCountries = await getCountries();
      dropMethods = getMethods();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLists();
    print('config exists: $configExistsBool');
  }

  @override
  Widget build(BuildContext context) {
    return configExistsBool == null
        ? Scaffold(
            appBar: AppBar(), body: Center(child: CircularProgressIndicator()))
        : configExistsBool == true
            ? HomeScreen()
            : Scaffold(
                appBar: AppBar(
                  title: Text('اختر مدينة', style:TextStyle(fontFamily: 'khatt')),
                  centerTitle: true,
                ),

                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        dropCountries.isEmpty
                            ? CircularProgressIndicator()
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton<String>(
                                          value: countrySelected,
                                          items: dropCountries,
                                          onChanged: (value) async {
                                            citySelected = null;
                                            countrySelected = value.toString();
                                            dropCities = await getCities(
                                                countrySelected);
                                            setState(() {});
                                          },
                                          hint: Text(
                                            'اختيار الدولة',
                                            style: TextStyle(fontFamily: 'khatt'),
                                            textAlign: TextAlign.center,
                                          ),
                                          isExpanded: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton<String>(
                                          value: citySelected,
                                          items: dropCities,
                                          onChanged: (value) {
                                            setState(() {
                                              citySelected = value.toString();
                                            });
                                          },
                                          hint: Text('اختيار المدينة', style: TextStyle(fontFamily: 'khatt'),),
                                          isExpanded: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton<int>(
                                          value: methodSelected,
                                          items: dropMethods,
                                          onChanged: (value) {
                                            setState(() {
                                              methodSelected = value;
                                            });
                                          },
                                          hint: Text('اختيار طريقة الحساب', style: TextStyle(fontFamily: 'khatt'),),
                                          isExpanded: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  ElevatedButton(
                                    child: Text(
                                      'حفظ',
                                      style: TextStyle(fontSize: 25, fontFamily: 'khatt'),
                                    ),
                                    style: elevatedButtonStyle(),
                                    onPressed: () async {
                                      print('city selected is $citySelected');
                                      if (citySelected != null &&
                                          methodSelected != null) {
                                        await makeConfig(
                                            citySelected, methodSelected);

                                        goWithoutBack(context, HomeScreen());
                                      } else {
                                        showMyDialog(
                                            context: context,
                                            title: 'اختيار ناقص',
                                            dismissible: true,
                                            msg: 'اختار كل الاختيارات يسطا',
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    goBack(context);
                                                  },
                                                  child: Text('ماشي'))
                                            ]);
                                      }
                                    },
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
