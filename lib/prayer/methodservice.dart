import 'package:flutter/material.dart';

List<DropdownMenuItem<int>> getMethods() {
  var methods = [
    'University of Islamic Sciences, Karachi', //1
    'Islamic Society of North America', // 2
    'Muslim World League', // 3
    'Umm Al-Qura University, Makkah', //4
    'Egyptian General Authority of Survey', //5
    'Institute of Geophysics, University of Tehran', //7
    'Gulf Region', //8
    'Kuwait', // 9
    'Qatar', // 10
    'Majlis Ugama Islam Singapura, Singapore', // 11
    'Union Organization islamic de France', //12
    'Diyanet İşleri Başkanlığı, Turkey', //13
    'Spiritual Administration of Muslims of Russia', //14
  ];
  var methodsNum = {
    'University of Islamic Sciences, Karachi': 1,
    'Islamic Society of North America': 2,
    'Muslim World League': 3,
    'Umm Al-Qura University, Makkah': 4,
    'Egyptian General Authority of Survey': 5,
    'Institute of Geophysics, University of Tehran': 7,
    'Gulf Region': 8,
    'Kuwait': 9,
    'Qatar': 10,
    'Majlis Ugama Islam Singapura, Singapore': 11,
    'Union Organization islamic de France': 12,
    'Diyanet İşleri Başkanlığı, Turkey': 13,
    'Spiritual Administration of Muslims of Russia': 14,
  };

  List<DropdownMenuItem<int>> dropMethods = methods.map((String item) {
    return DropdownMenuItem<int>(
        child: Text(
          '$item',
          style: TextStyle(fontSize: 25),
          overflow: TextOverflow.ellipsis,
        ),
        value: methodsNum['$item']);
  }).toList();
  return dropMethods;
}
