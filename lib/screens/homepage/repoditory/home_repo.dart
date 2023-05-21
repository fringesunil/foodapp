import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/homepage/models/home_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  DatabaseReference ref = FirebaseDatabase.instance.ref('orders');
  Future getSaladsAPI({required BuildContext context}) async {
    final response = await http
        .get(Uri.parse("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad"));
    final data = jsonDecode(response.body);

    print(data[0]["table_menu_list"]);
    return hotelFromJson(response.body);
  }

  Future<void> order(Map data) async {
    print("1");
    await ref.child(data["user_id"]).child(data["dish_id"]).set(data);
  }
}
