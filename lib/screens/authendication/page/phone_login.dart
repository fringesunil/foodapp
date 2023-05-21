import 'package:flutter/material.dart';
import 'package:foodapp/screens/authendication/provider/authendicationprovider.dart';
import 'package:provider/provider.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Consumer<AuthendicationProvider>(
            builder: (context, auth, child) => Form(
                  key: auth.phoneloginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            'Login Via Phone Number',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF4C637A),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0.4),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: auth.phone,
                          validator: auth.validator.phonevalidator,
                          //keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            hintText: 'Phone Number with country code',
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (auth.phoneloginKey.currentState!.validate()) {
                            auth.phoneLogin(context);
                          }
                        },
                        child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.2, horizontal: 0.2),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFFFFFFFF)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
