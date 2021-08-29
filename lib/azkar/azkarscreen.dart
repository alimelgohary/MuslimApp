import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:muslimapp/azkar/azkarService.dart';
import 'package:muslimapp/utils.dart';
import 'package:muslimapp/widgets.dart';

//import 'package:muslimapp/prayer/utils.dart';

class AzkarScreen extends StatefulWidget {
  String category;
  AzkarScreen(this.category);

  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  List<String> zekr = [];
  List<String> zekrInfo = [];
  List<int> zekrCount = [];
  List<bool> zekrExpanded = [];

  Future<void> getLists() async {
    zekr = await getZekrList(widget.category);
    zekrInfo = await getZekrInfoList(widget.category);
    zekrCount = await getZekrCountList(widget.category);
    zekrExpanded = List.generate(zekr.length, (index) => false);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "${widget.category}",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: (zekr.isEmpty || zekrInfo.isEmpty || zekrCount.isEmpty)
          ? containerWithBackground(
              child: Center(child: CircularProgressIndicator()))
          : containerWithBackground(
              child: ListView.builder(
                padding: EdgeInsets.all(30),
                itemCount: zekr.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                          onTap: () {
                            if (zekrCount[index] == 1) {
                              zekr.remove(zekr[index]);
                              zekrInfo.remove(zekrInfo[index]);
                              zekrCount.remove(zekrCount[index]);
                              zekrExpanded.remove(zekrExpanded[index]);
                              if (zekr.isEmpty) {
                                goBack(context);
                              }
                            } else {
                              zekrCount[index] = zekrCount[index] - 1;
                            }

                            setState(() {
                              print(zekr);
                              print(zekrInfo);
                              print(zekrCount);
                              print(zekrExpanded);
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Card(
                                    color: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            '${zekr[index]}',
                                            style: TextStyle(
                                                fontFamily: 'ruqaa',
                                                fontSize: 22,
                                                color: Colors.white),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            '${zekrInfo[index]}',
                                            style: TextStyle(
                                                fontFamily: 'khatt',
                                                fontSize: 15,
                                                color: Colors.white),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Card(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Card(
                                    color: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'عدد مرات التكرار: ${zekrCount[index]}',
                                          style: TextStyle(
                                              fontFamily: 'khatt',
                                              fontSize: 15,
                                              color: Colors.white),
                                          textAlign: TextAlign.right,
                                        ),
                                      )))
                            ],
                          ))
                    ],
                  );
                },
              ),
            ),
    );
  }
}
