import 'dart:async';
import 'package:flutter/material.dart';
import 'package:muslimapp/prayer/choosecity.dart';

void main() {
  // runZonedGuarded(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     FlutterError.dumpErrorToConsole(details);
  //     runApp(MaterialApp(home: Scaffold(body:Center(child:Text('$details', style: TextStyle(color: Colors.blue),)))));
  //   };
    runApp(MyApp());
  // }, (Object error, StackTrace stack) {
  // runApp(MaterialApp(home: Scaffold(body:Center(child:Text('$error', style: TextStyle(color: Colors.red),)))));
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (BuildContext context, Widget? widget) {
      //   ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      //     return Scaffold(body: Center(child: Text('$errorDetails', style: TextStyle(color: Colors.green),)));
      //   };
      //   return widget!;
      // },
      debugShowCheckedModeBanner: false,
      title: 'تطبيق المسلم',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SelectCity(),

    );
  }
}
