import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/common/common_methods.dart';
import 'package:foodapp/screens/authendication/provider/authendicationprovider.dart';
import 'package:foodapp/screens/homepage/provider/home_provider.dart';
import 'package:foodapp/screens/orderpage/page/order_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget with CommonMethods {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isSelected = [false, false, false];

  @override
  void initState() {
    var home = Provider.of<HomeProvider>(context, listen: false);
    home.getSalads(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var auth = Provider.of<AuthendicationProvider>(context, listen: false);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.grey),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrderPage()));
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Salads and Soup",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    "From The Barnyard",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    "From the Hen House",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    "Fresh From The Sea",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    "Biryani",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Tab(
                  child: Text(
                    "Fast Food",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
              indicatorColor: Colors.red,
              isScrollable: true,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15))),
                    child: FutureBuilder<DatabaseEvent>(
                        future: FirebaseDatabase.instance.ref('user').once(),
                        builder: (context, snapshot) {
                          
                          return Column(
                            children: [
                              const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.image)),
                              Text("${auth.user?.displayName}"),
                              Text("${auth.user1?.uid}")
                            ],
                          );
                        })),
                ListTile(
                  leading: Icon(Icons.logout, size: 30, color: Colors.black),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                content: SizedBox(
                              height: size.height * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Would you like to log out?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: size.width * 0.2,
                                          height: size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.black,
                                          ),
                                          child: const Text(
                                            "No",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          var auth = Provider.of<
                                                  AuthendicationProvider>(
                                              context,
                                              listen: false);
                                          auth.signOutFunc(context);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: size.width * 0.2,
                                          height: size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.black,
                                          ),
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )));
                  },
                ),
              ],
            ),
          ),
          body: Consumer2<HomeProvider, AuthendicationProvider>(
              builder: (context, home, auth, child) => TabBarView(children: [
                    //menu_category": "Salads and Soup"
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home
                              .hotel![0].tableMenuList[0].categoryDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return home.hotel != null
                                ? Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: size.height * 0.29,
                                      width: size.width * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
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
                                                child: Text(home
                                                    .hotel![0]
                                                    .tableMenuList[0]
                                                    .categoryDishes[index]
                                                    .dishName),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.4,
                                                child: Text(
                                                    "INR ${home.hotel![0].tableMenuList[0].categoryDishes[index].dishPrice}"),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.04,
                                                width: size.width * 0.4,
                                                child: Text(home
                                                    .hotel![0]
                                                    .tableMenuList[0]
                                                    .categoryDishes[index]
                                                    .dishDescription),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              ToggleButtons(
                                                onPressed: (index) {},
                                                isSelected: isSelected,
                                                borderWidth: 1,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (home.finalcount[
                                                                  index] >
                                                              0) {
                                                            home.finalcount[
                                                                    index] =
                                                                home.finalcount[
                                                                        index] -
                                                                    1;
                                                          } else {
                                                            return;
                                                          }
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: Color(
                                                              0xFF4C637A)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2),
                                                    child: Text(
                                                      '${home.finalcount[index]}',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF4C637A)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          home.finalcount[
                                                                  index] =
                                                              home.finalcount[
                                                                      index] +
                                                                  1;
                                                        });
                                                        home.addCart(
                                                            auth.user1!.uid,
                                                            home
                                                                .hotel![0]
                                                                .tableMenuList[
                                                                    0]
                                                                .categoryDishes[
                                                                    index]
                                                                .dishId,
                                                            home
                                                                .hotel![0]
                                                                .tableMenuList[
                                                                    0]
                                                                .categoryDishes[
                                                                    index]
                                                                .dishName,
                                                            home
                                                                .hotel![0]
                                                                .tableMenuList[
                                                                    0]
                                                                .categoryDishes[
                                                                    index]
                                                                .dishPrice,
                                                            home
                                                                .hotel![0]
                                                                .tableMenuList[
                                                                    0]
                                                                .categoryDishes[
                                                                    index]
                                                                .dishCalories,
                                                            home.finalcount[
                                                                index]);
                                                      },
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: Color(
                                                              0xFF4C637A)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: size.width * 0.12,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                  color: Colors.grey[300],
                                                  height: size.height * 0.2,
                                                  width: size.width * 0.4,
                                                  child: Image.network(home
                                                      .hotel![0]
                                                      .tableMenuList[0]
                                                      .categoryDishes[index]
                                                      .dishImage)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const Card();
                          }),
                    ),

                    //menu_category": "From The Barnyard"
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home
                              .hotel![0].tableMenuList[1].categoryDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: size.height * 0.29,
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
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[1]
                                              .categoryDishes[index]
                                              .dishName),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "INR ${home.hotel![0].tableMenuList[1].categoryDishes[index].dishPrice}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[1]
                                              .categoryDishes[index]
                                              .dishDescription),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        ToggleButtons(
                                          onPressed: (index) {},
                                          isSelected: isSelected,
                                          borderWidth: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (home.finalcount1[
                                                            index] >
                                                        0) {
                                                      home.finalcount1[index] =
                                                          home.finalcount1[
                                                                  index] -
                                                              1;
                                                    } else {
                                                      return;
                                                    }
                                                  });
                                                },
                                                child: const Icon(Icons.remove,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Text(
                                                '${home.finalcount1[index]}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    home.finalcount1[index] =
                                                        home.finalcount1[
                                                                index] +
                                                            1;
                                                  });
                                                  home.addCart(
                                                      auth.user1!.uid,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[1]
                                                          .categoryDishes[index]
                                                          .dishId,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[1]
                                                          .categoryDishes[index]
                                                          .dishName,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[1]
                                                          .categoryDishes[index]
                                                          .dishPrice,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[1]
                                                          .categoryDishes[index]
                                                          .dishCalories,
                                                      home.finalcount1[index]);
                                                },
                                                child: const Icon(Icons.add,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.12,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            color: Colors.grey[300],
                                            height: size.height * 0.2,
                                            width: size.width * 0.4,
                                            child: Image.network(home
                                                .hotel![0]
                                                .tableMenuList[1]
                                                .categoryDishes[index]
                                                .dishImage)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    //menu_category": "From the Hen House"
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home
                              .hotel![0].tableMenuList[2].categoryDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: size.height * 0.29,
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
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[2]
                                              .categoryDishes[index]
                                              .dishName),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "INR ${home.hotel![0].tableMenuList[2].categoryDishes[index].dishPrice}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[2]
                                              .categoryDishes[index]
                                              .dishDescription),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        ToggleButtons(
                                          onPressed: (index) {},
                                          isSelected: isSelected,
                                          borderWidth: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (home.finalcount2[
                                                            index] >
                                                        0) {
                                                      home.finalcount2[index] =
                                                          home.finalcount2[
                                                                  index] -
                                                              1;
                                                    } else {
                                                      return;
                                                    }
                                                  });
                                                },
                                                child: const Icon(Icons.remove,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Text(
                                                '${home.finalcount2[index]}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    home.finalcount2[index] =
                                                        home.finalcount2[
                                                                index] +
                                                            1;
                                                  });
                                                  home.addCart(
                                                      auth.user1!.uid,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[2]
                                                          .categoryDishes[index]
                                                          .dishId,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[2]
                                                          .categoryDishes[index]
                                                          .dishName,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[2]
                                                          .categoryDishes[index]
                                                          .dishPrice,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[2]
                                                          .categoryDishes[index]
                                                          .dishCalories,
                                                      home.finalcount2[index]);
                                                },
                                                child: const Icon(Icons.add,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.12,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            color: Colors.grey[300],
                                            height: size.height * 0.2,
                                            width: size.width * 0.4,
                                            child: Image.network(home
                                                .hotel![0]
                                                .tableMenuList[2]
                                                .categoryDishes[index]
                                                .dishImage)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    //menu_category": "Fresh From The Sea"
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home
                              .hotel![0].tableMenuList[3].categoryDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: size.height * 0.29,
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
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[3]
                                              .categoryDishes[index]
                                              .dishName),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "INR ${home.hotel![0].tableMenuList[3].categoryDishes[index].dishPrice}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[3]
                                              .categoryDishes[index]
                                              .dishDescription),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        ToggleButtons(
                                          onPressed: (index) {},
                                          isSelected: isSelected,
                                          borderWidth: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (home.finalcount3[
                                                            index] >
                                                        0) {
                                                      home.finalcount3[index] =
                                                          home.finalcount3[
                                                                  index] -
                                                              1;
                                                    } else {
                                                      return;
                                                    }
                                                  });
                                                },
                                                child: const Icon(Icons.remove,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Text(
                                                '${home.finalcount3[index]}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    home.finalcount3[index] =
                                                        home.finalcount3[
                                                                index] +
                                                            1;
                                                  });
                                                  home.addCart(
                                                      auth.user1!.uid,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[3]
                                                          .categoryDishes[index]
                                                          .dishId,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[3]
                                                          .categoryDishes[index]
                                                          .dishName,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[3]
                                                          .categoryDishes[index]
                                                          .dishPrice,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[3]
                                                          .categoryDishes[index]
                                                          .dishCalories,
                                                      home.finalcount3[index]);
                                                },
                                                child: const Icon(Icons.add,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.12,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            color: Colors.grey[300],
                                            height: size.height * 0.2,
                                            width: size.width * 0.4,
                                            child: Image.network(home
                                                .hotel![0]
                                                .tableMenuList[3]
                                                .categoryDishes[index]
                                                .dishImage)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    //menu_category": "Biryani"
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home
                              .hotel![0].tableMenuList[4].categoryDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: size.height * 0.29,
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
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[4]
                                              .categoryDishes[index]
                                              .dishName),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "INR ${home.hotel![0].tableMenuList[4].categoryDishes[index].dishPrice}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[4]
                                              .categoryDishes[index]
                                              .dishDescription),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        ToggleButtons(
                                          onPressed: (index) {},
                                          isSelected: isSelected,
                                          borderWidth: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (home.finalcount4[
                                                            index] >
                                                        0) {
                                                      home.finalcount4[index] =
                                                          home.finalcount4[
                                                                  index] -
                                                              1;
                                                    } else {
                                                      return;
                                                    }
                                                  });
                                                },
                                                child: const Icon(Icons.remove,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Text(
                                                '${home.finalcount4[index]}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    home.finalcount4[index] =
                                                        home.finalcount4[
                                                                index] +
                                                            1;
                                                  });
                                                  home.addCart(
                                                      auth.user1!.uid,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[4]
                                                          .categoryDishes[index]
                                                          .dishId,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[4]
                                                          .categoryDishes[index]
                                                          .dishName,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[4]
                                                          .categoryDishes[index]
                                                          .dishPrice,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[4]
                                                          .categoryDishes[index]
                                                          .dishCalories,
                                                      home.finalcount4[index]);
                                                },
                                                child: const Icon(Icons.add,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.12,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            color: Colors.grey[300],
                                            height: size.height * 0.2,
                                            width: size.width * 0.4,
                                            child: Image.network(home
                                                .hotel![0]
                                                .tableMenuList[4]
                                                .categoryDishes[index]
                                                .dishImage)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    //menu_category": "Fast Food"
                    SingleChildScrollView(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: home
                              .hotel![0].tableMenuList[5].categoryDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: size.height * 0.29,
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
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[5]
                                              .categoryDishes[index]
                                              .dishName),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(
                                              "INR ${home.hotel![0].tableMenuList[5].categoryDishes[index].dishPrice}"),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                          width: size.width * 0.4,
                                          child: Text(home
                                              .hotel![0]
                                              .tableMenuList[5]
                                              .categoryDishes[index]
                                              .dishDescription),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        ToggleButtons(
                                          onPressed: (index) {},
                                          isSelected: isSelected,
                                          borderWidth: 1,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (home.finalcount5[
                                                            index] >
                                                        0) {
                                                      home.finalcount5[index] =
                                                          home.finalcount5[
                                                                  index] -
                                                              1;
                                                    } else {
                                                      return;
                                                    }
                                                  });
                                                },
                                                child: const Icon(Icons.remove,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Text(
                                                '${home.finalcount5[index]}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    home.finalcount5[index] =
                                                        home.finalcount5[
                                                                index] +
                                                            1;
                                                  });
                                                  home.addCart(
                                                      auth.user1!.uid,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[5]
                                                          .categoryDishes[index]
                                                          .dishId,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[5]
                                                          .categoryDishes[index]
                                                          .dishName,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[5]
                                                          .categoryDishes[index]
                                                          .dishPrice,
                                                      home
                                                          .hotel![0]
                                                          .tableMenuList[5]
                                                          .categoryDishes[index]
                                                          .dishCalories,
                                                      home.finalcount5[index]);
                                                },
                                                child: const Icon(Icons.add,
                                                    color: Color(0xFF4C637A)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.12,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            color: Colors.grey[300],
                                            height: size.height * 0.2,
                                            width: size.width * 0.4,
                                            child: Image.network(home
                                                .hotel![0]
                                                .tableMenuList[5]
                                                .categoryDishes[index]
                                                .dishImage)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ]))),
    );
  }
}
