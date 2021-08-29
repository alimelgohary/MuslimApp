import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:muslimapp/azkar/azkarService.dart';
import 'package:muslimapp/azkar/azkarscreen.dart';
import 'package:muslimapp/widgets.dart';
import 'package:sqflite/sqflite.dart';
import '../utils.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categories = [];
  bool loading = true;

  void getCategories() async {
    categories = await getZekrCategoriesList();
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  String appBarText = " قائمة اﻷذكار";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appBarText,
          style: TextStyle(fontSize: 25, fontFamily: 'khatt'),
        ),
      ),
      body: containerWithBackground(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                            onPressed: () {
                              go(context, AzkarScreen(categories[index]));
                            },
                            style: elevatedButtonStyle(),
                            child: Text(
                              "${categories[index]}",
                              style: TextStyle(fontSize: 25, fontFamily: 'khatt'),
                              textAlign: TextAlign.center,
                            )),
                      );
                    }),
              ),
      ),
    );
  }
}
