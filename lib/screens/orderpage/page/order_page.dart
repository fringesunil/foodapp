import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/homepage/page/home_page.dart';
import 'package:provider/provider.dart';

import '../../authendication/provider/authendicationprovider.dart';
import '../../homepage/provider/home_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer2<HomeProvider, AuthendicationProvider>(
        builder: (context, home, auth, child) => SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder<DatabaseEvent>(
                future: FirebaseDatabase.instance
                    .ref('orders')
                    .child(auth.user1!.uid)
                    .once(),
                builder: (context, snapshot) {
                  home.orderlist = snapshot.data!.snapshot.children
                      .map((e) => e.value)
                      .toList();

                  return snapshot.data != null
                      ? ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home.orderlist.length,
                          itemBuilder: (context, index) {
                            var total = (home.orderlist[index]["quantity"]) *
                                (home.orderlist[index]["dish_price"]);

                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: size.height * 0.18,
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "${home.orderlist[index]["dish_name"]}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "INR ${home.orderlist[index]["dish_price"]}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "${home.orderlist[index]["dish_calories"]} Calories"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.12,
                                    ),
                                    Column(children: [
                                      Container(
                                          color: Colors.white,
                                          height: size.height * 0.1,
                                          width: size.width * 0.4,
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Total: ${home.orderlist[index]["quantity"]} * ${home.orderlist[index]["dish_price"]}"),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                "= ${total}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )))
                                    ]),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Text("No Data");
                }),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(
              onTap: () {
                home.placeOrder(context, auth.user1!.uid);
              },
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.9,
                padding:
                    const EdgeInsets.symmetric(vertical: 0.2, horizontal: 0.2),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    'Place Order',
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        )),
      ),
    );
  }
}
