import 'package:flutter/material.dart';
import 'package:foodapp/screens/authendication/page/phone_login.dart';
import 'package:foodapp/screens/authendication/provider/authendicationprovider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthendicationProvider>(
          builder: (context, auth, child) => Form(
                key: auth.loginKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/fire.png'),
                    ),
                    SizedBox(
                      height: size.height * 0.09,
                    ),
                    InkWell(
                      onTap: () {
                        auth.googleLogin(context);
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: size.height * 0.04,
                              width: size.width * 0.08,
                              color: Colors.white,
                              child: Image.asset('assets/glogo.png'),
                            ),
                            SizedBox(
                              width: size.width * 0.22,
                            ),
                            const Text(
                              "Google",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneLogin()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.22,
                            ),
                            const Text(
                              "Phone",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
