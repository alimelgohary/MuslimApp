import 'package:flutter/material.dart';
import 'package:muslimapp/utils.dart';
import 'package:sqflite/sqflite.dart';

Future<List<DropdownMenuItem<String>>> getCities(String countrySelected) async {
  Database citiesDb = await dbFromAssets("cities.db");
  List<DropdownMenuItem<String>> dropCities = [];
  List<String> cities = [];
  List<Map> resultCities = await citiesDb.query('mytable',
      columns: ['city_ascii'],
      orderBy: "city_ascii",
      where: 'country = ?',
      whereArgs: [countrySelected]);
  resultCities.forEach((row) {
    cities.add(row['city_ascii'].toString());
  });
  dropCities = cities.map((String item) {
    return DropdownMenuItem<String>(
        child: Text(
          '$item',
          style: TextStyle(fontSize: 25),
          overflow: TextOverflow.ellipsis,
        ),
        value: item);
  }).toList();
  return dropCities;
}