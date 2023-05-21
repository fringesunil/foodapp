import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/authendication/page/login_page.dart';
import 'package:foodapp/screens/authendication/provider/authendicationprovider.dart';
import 'package:foodapp/screens/homepage/provider/home_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthendicationProvider>(
            create: (_) => AuthendicationProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        //  initialRoute: AppRoutes.login,
        //   onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
