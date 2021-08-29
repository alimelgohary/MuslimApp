import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:muslimapp/utils.dart';
import 'package:sqflite/sqflite.dart';

import 'prayermodel.dart';

class PrayerService {
  Future<List<PrayerModel>> getList(
    String city, int method) async {

    Database citiesDb = await dbFromAssets('cities.db');
    List<double> location = [];
    List<Map> resultLocation = await citiesDb.query('mytable',
        columns: ['lat', 'lng'], where: 'city_ascii = ?', whereArgs: ['$city']);
    location.add(double.parse(resultLocation[0]['lat'].toString()));
    location.add(double.parse(resultLocation[0]['lng'].toString()));
    citiesDb.close();

    List<int> date = getCurrentDate();

    String request = 'http://api.aladhan.com/v1/calendar?latitude=${location[0]}&longitude=${location[1]}&method=$method&month=${date[1]}&year=${date[2]}';

    List<PrayerModel> list = [];


    // if(await responseExists(city, method, date[1], date[2])){
    //   list = await readResponse(city, method, date[1], date[2]);
    // }
    // else{
    //     var res = await Dio().get('$request');
    //     if (res.statusCode == 200) {
    //       print('Api request 200');
    //       res.data['data'].forEach((var val) {
    //         PrayerModel p = PrayerModel.fromJson(val);
    //         list.add(p);
    //       });
    //       writeResponse(city, method, date[1], date[2], list);
    //     }
    //     else{
    //       print('Api request failed with code ${res.statusCode}');
    //     }
    //
    //
    // }




      var res = await Dio().get('$request');
      if (res.statusCode == 200) {
        print('Api request 200');
        res.data['data'].forEach((var val) {
          PrayerModel p = PrayerModel.fromJson(val);
          list.add(p);
        });
      }
      else{
        print('Api request failed with code ${res.statusCode}');
      }
      //print(response);



    return list;
  }
}
