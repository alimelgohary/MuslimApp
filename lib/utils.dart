import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> dbFromAssets(String dbName) async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "$dbName");
  var exists = await databaseExists(path);

  if (!exists) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "$dbName"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }
// open the database
  return await openDatabase(path, readOnly: true);
}

void go(BuildContext context, Widget w) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => w),
  );
}

void goBack(BuildContext context) {
  Navigator.pop(
    context,
  );
}

void goWithoutBack(BuildContext context, Widget m) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => m),
      (Route<dynamic> route) => false);
}

Future<void> showMyDialog(
    {required BuildContext context,
    required String title,
    required String msg,
    required bool dismissible,
    required List<Widget> actions}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$msg'),
              ],
            ),
          ),
          actions: actions);
    },
  );
}

List<int> getCurrentDate() {
  var dateParse = DateTime.parse(DateTime.now().toString());
  List<int> date = [dateParse.day, dateParse.month, dateParse.year];
  return date;
}

Future<bool> configExists() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, 'userConfig.db');
  var exists = await databaseExists(path);
  if (exists) {
    return true;
  } else {
    return false;
  }
}

Future<Map<dynamic, dynamic>> readConfig() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, 'userConfig.db');
  var a = await openDatabase(path);
  List<Map> res = await a.query('user');
  print(res);
  a.close();
  return res[0];
}

Future<void> makeConfig(String city, int method) async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "userConfig.db");

  // Make sure the parent directory exists
  try {
    await Directory(dirname(path)).create(recursive: true);
  } catch (_) {}

  var db = await openDatabase(path);
  await db.execute(
      'CREATE TABLE user(city_ascii VARCHAR(49) NOT NULL, method INTEGER)');
  await db.insert('user', {'city_ascii': city, 'method': method});
  db.close();
}

void deleteConfig() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "userConfig.db");
  bool b = await databaseExists(path);
  if (b) {
    await deleteDatabase(path);
  }
}

ButtonStyle elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  );
}

// '04:55 (EET)' to '04:55'
String removeTimeZone(String s) {
  int n = s.indexOf('(');
  return s.substring(0, n - 1);
}

String? getMonthArabic(int n) {
  Map<int, String> m = {
    1: 'يناير',
    2: 'فبراير',
    3: 'مارس',
    4: 'إبريل',
    5: 'مايو',
    6: 'يونيو',
    7: 'يوليو',
    8: 'أغسطس',
    9: 'سبتمبر',
    10: 'أكتوبر',
    11: 'نوفمبر',
    12: 'ديسمبر'
  };
  return m[n];
}

Future<bool> internetConnected() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else{
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }

}
