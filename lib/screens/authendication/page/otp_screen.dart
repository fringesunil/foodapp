import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/authendication/provider/authendicationprovider.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final authe = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Consumer<AuthendicationProvider>(
            builder: (context, auth, child) => Form(
                  key: auth.otpKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            'OTP',
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
                          keyboardType: TextInputType.number,
                          controller: auth.otp,
                          validator: auth.validator.otpvalidator,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            hintText: 'Enter OTP',
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
                        onTap: () async {
                          if (auth.otpKey.currentState!.validate()) {
                            auth.otpVerify(context, widget.verificationId);
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
                              'VERIFY',
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
