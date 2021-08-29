import 'package:flutter/material.dart';
import 'package:muslimapp/azkar/catscreen.dart';
import 'package:muslimapp/azkar/azkarscreen.dart';
import 'package:muslimapp/screens/msbha.dart';
import 'package:muslimapp/widgets.dart';
import 'package:muslimapp/prayer/prayerscreen.dart';
import 'package:muslimapp/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data = {};
  void fillConfig() async {
    data = await readConfig();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fillConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الصفحة الرئيسية',
          style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'khatt'),
        ),
        centerTitle: true,
      ),
      body: containerWithBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                data.isEmpty
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          ElevatedButton(
                              style: elevatedButtonStyle(),
                              onPressed: () {
                                go(context, CategoryScreen());
                              },
                              child: Text('الأذكار',
                                  style: TextStyle(fontSize: 25, fontFamily: 'khatt'),
                                  textAlign: TextAlign.center)),
                          Padding(padding: EdgeInsets.all(30)),
                          ElevatedButton(
                              style: elevatedButtonStyle(),
                              onPressed: () {
                                go(
                                    context,
                                    PrayerScreen(
                                        data['city_ascii'], data['method']));
                              },
                              child: Text(
                                'مواقيت الصلاة',
                                style: TextStyle(fontSize: 25, fontFamily: 'khatt'),
                                textAlign: TextAlign.center,
                              )),
                          Padding(padding: EdgeInsets.all(30)),
                          ElevatedButton(
                              style: elevatedButtonStyle(),
                              onPressed: () {
                                go(context, msbaha());
                              },
                              child: Text('السبحة',
                                  style: TextStyle(fontSize: 25, fontFamily: 'khatt'),
                                  textAlign: TextAlign.center)),

                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
