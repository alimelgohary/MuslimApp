import 'package:flutter/material.dart';
import 'package:muslimapp/utils.dart';
import 'package:sqflite/sqflite.dart';

Future<List<DropdownMenuItem<String>>> getCountries() async {
  Database citiesDb = await dbFromAssets("cities.db");
  List<String> countries = [];
  List<Map> resultCountry = await citiesDb.query('mytable',
      columns: ['country'], distinct: true, orderBy: "country");
  resultCountry.forEach((row) {
    countries.add(row['country'].toString());
  });
  List<DropdownMenuItem<String>> dropCountries = countries.map((String item) {
    return DropdownMenuItem<String>(
        child: Text(
          '$item',
          style: TextStyle(fontSize: 25),
          overflow: TextOverflow.ellipsis,
        ),
        value: item);
  }).toList();
  return dropCountries;
}