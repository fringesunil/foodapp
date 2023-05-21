import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/common/common_methods.dart';
import 'package:foodapp/screens/homepage/models/home_model.dart';
import 'package:foodapp/screens/homepage/repoditory/home_repo.dart';

class HomeProvider extends HomeRepository with ChangeNotifier, CommonMethods {
  // final GlobalKey<FormState> homeKey = GlobalKey<FormState>();
  TextEditingController dishname = TextEditingController();
  TextEditingController dishprice = TextEditingController();
  TextEditingController dishdiscription = TextEditingController();

  int count = 0;
  List finalcount = [0, 0, 0, 0, 0, 0];
  List finalcount1 = [0, 0, 0, 0, 0, 0];
  List finalcount2 = [0, 0, 0, 0, 0, 0];
  List finalcount3 = [0, 0, 0, 0, 0, 0];
  List finalcount4 = [0, 0, 0, 0, 0, 0];
  List finalcount5 = [0, 0, 0, 0, 0, 0];
  List<dynamic>? tableMenuList = [];
  List<CategoryDish>? categoryDishes = [];
  List<Hotel>? hotel;
  TableMenuList? table;
  CategoryDish? dish;
  List orderlist = [];

  getSalads(BuildContext context) async {
    hotel = await getSaladsAPI(context: context);
    notifyListeners();
  }

  addCart(uid, id, name, price, cal, quantity) async {
    await order({
      "dish_id": id,
      "dish_name": name,
      "dish_price": price,
      "user_id": uid,
      "dish_calories": cal,
      "quantity": quantity
    });
  }

  void placeOrder(BuildContext context, uid) async {
    DatabaseReference orderRemove =
        FirebaseDatabase.instance.ref('orders/$uid');
    await orderRemove.remove();

    getSnackbar(context, "Order Placed Sucessfully");
    back(context);
  }
}
