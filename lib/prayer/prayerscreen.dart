import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muslimapp/prayer/prayermodel.dart';
import 'package:muslimapp/prayer/prayerservice.dart';
import 'package:muslimapp/utils.dart';
import 'package:muslimapp/widgets.dart';
import 'choosecity.dart';

class PrayerScreen extends StatefulWidget {
  PrayerScreen(this.city, this.method);
  String city;
  int method;

  @override
  _PrayerScreenState createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  List<PrayerModel> prayerList = [];
  List<String> times = [];
  List<String> salawat = [];
  int currentDay = 0;
  void getPrayerList() async {
    if(await internetConnected()) {
      prayerList = await PrayerService().getList(widget.city, widget.method);
      currentDay = getCurrentDate()[0] - 1;
      salawat = ['الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'];
      times = [
        removeTimeZone(prayerList[currentDay].timings.fajr),
        removeTimeZone(prayerList[currentDay].timings.sunrise),
        removeTimeZone(prayerList[currentDay].timings.dhuhr),
        removeTimeZone(prayerList[currentDay].timings.asr),
        removeTimeZone(prayerList[currentDay].timings.maghrib),
        removeTimeZone(prayerList[currentDay].timings.isha)
      ];
      setState(() {});
    }
    else{
      Fluttertoast.showToast(
          msg: "فشل الإتصال بالإنترنت",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3
      );
      goBack(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getPrayerList();
  }

  @override
  Widget build(BuildContext context) {
    return prayerList.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'أوقات الصلاة',
                style: TextStyle(fontFamily: 'khatt'),
              ),
              centerTitle: true,
            ),
            body: containerWithBackground(child: Center(child: CircularProgressIndicator())),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                '${prayerList[currentDay].date.hijri.weekday.ar} ${prayerList[currentDay].date.gregorian.day} ${getMonthArabic(prayerList[currentDay].date.gregorian.month.number)} ${prayerList[currentDay].date.gregorian.year} م',
                style: TextStyle(fontSize: 25, fontFamily: 'ruqaa'),
              ),
              centerTitle: true,
            ),
            floatingActionButton: ElevatedButton(
                onPressed: () {
                  deleteConfig();
                  goWithoutBack(context, SelectCity());
                },
                child: Text('${widget.city} تغيير المدينة',
                    style: TextStyle(fontSize: 12))),
            body: containerWithBackground(
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: ListView.builder(
                  itemCount: times.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                            width: double.infinity,
                            child: Card(
                              color: Colors.green[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                '${salawat[index]}: ${times[index]}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'khatt',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ));
  }
}
