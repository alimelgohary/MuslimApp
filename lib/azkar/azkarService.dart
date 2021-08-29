import 'package:muslimapp/utils.dart';
import 'package:sqflite/sqflite.dart';

Future<List<String>> getZekrCategoriesList() async {
  Database azkarDb = await dbFromAssets("azkar-db.db");
  List<Map> m = await azkarDb.query('azkar',
      columns: ['type'], distinct: true);
  List<String> catList = [];
  m.forEach((mapi) {
    catList.add(mapi['type']);
  });
  azkarDb.close();
  return catList;
}
  Future<List<String>> getZekrList(String cat) async {
    Database azkarDb = await dbFromAssets("azkar-db.db");
    List<Map> m = await azkarDb.query('azkar',
        columns: ['zekr'], where: 'type = ?', whereArgs: ['$cat']);
    List<String> zekrList = [];
    m.forEach((mapi) {
      zekrList.add(mapi['zekr']);
    });
    azkarDb.close();
    return zekrList;
  }

  Future<List<String>> getZekrInfoList(String cat) async {
    Database azkarDb = await dbFromAssets("azkar-db.db");
    List<Map> m = await azkarDb.query('azkar',
        columns: ['zekr_info'], where: 'type = ?', whereArgs: ['$cat']);
    List<String> zekrInfoList = [];
    m.forEach((mapi) {
      zekrInfoList.add(mapi['zekr_info']);
    });
    azkarDb.close();
    return zekrInfoList;
  }

  Future<List<int>> getZekrCountList(String cat) async {
    Database azkarDb = await dbFromAssets("azkar-db.db");
    List<Map> m = await azkarDb.query('azkar',
        columns: ['num_zekr'], where: 'type = ?', whereArgs: ['$cat']);
    List<int> zekrCount = [];
    m.forEach((mapi) {
      zekrCount.add(int.parse(mapi['num_zekr']));
    });
    azkarDb.close();
    return zekrCount;
  }
