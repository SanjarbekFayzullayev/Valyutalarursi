import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/data_model.dart';

class MainProvider extends ChangeNotifier {

  String? selectedDate;
  List<DataModel> dataModel = [];
  Future<List<DataModel>> getRequestHttp() async {
    String date =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

    String myUrl =
        "https://cbu.uz/uz/arkhiv-kursov-valyut/json/all/${selectedDate?? date}/";

    Uri url = Uri.parse(myUrl);
    var response = await http.get(url);
    List<dynamic> data = jsonDecode(response.body);
    dataModel.clear();
    data.forEach((element) {
      dataModel.add(DataModel.fromJson(element));
    });

    return dataModel;
  }

  late int card2 = 3;
  late int card = 1;

  void getInt2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value2 = prefs.getInt("view2") ?? 2;

    card2 = value2;
  }

  void getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value2 = prefs.getInt("view") ?? 0;

    card = value2;
  }

  void saveIntData(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('view', value);
  }

  void saveIntData2(int value2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('view2', value2);
  }

  void getClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    card = 23;
    card2 = 8;
  }

  void saveClear(int value, int value2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('view', value);
    prefs.setInt('view2', value2);
  }

  void refresh() {
    notifyListeners();
  }
}
