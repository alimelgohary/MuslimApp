import 'package:flutter/material.dart';
import 'package:muslimapp/widgets.dart';

class msbaha extends StatefulWidget {
  @override
  _msbahaState createState() => _msbahaState();
}

class _msbahaState extends State<msbaha> {
  int counter = 0;
  String _counter = '0';
  void _incrementCounter() {
    setState(() {
      counter++;
      _counter = counter.toString();
    });
  }

  void make_counterZero() {
    setState(() {
      counter = 0;
      _counter = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.teal,
        textStyle: const TextStyle(fontSize: 28, fontFamily: 'khatt'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ));
    return Center(
      child: Scaffold(
        appBar: AppBar(
            title: Text('مسبحة',
                style: TextStyle(fontSize: 40, fontFamily: 'khatt')),
            centerTitle: true,
            backgroundColor: Colors.teal[300]),
        body: containerWithBackground(
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: _incrementCounter,
                  child: Card(
                    color: Colors.teal[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Card(
                              color: Colors.green[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Container(
                                  height: 150,
                                  width: 200,
                                  child: Center(
                                      child: Text(
                                    _counter,
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.white,
                                        fontFamily: 'Prospek'),
                                  ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: style,
                      onPressed: make_counterZero,
                      child: const Text('   تصفير العداد'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
