import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/common/common_methods.dart';
import 'package:foodapp/core/common/validators.dart';
import 'package:foodapp/screens/authendication/page/login_page.dart';
import 'package:foodapp/screens/authendication/page/otp_screen.dart';
import 'package:foodapp/screens/homepage/page/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodapp/screens/authendication/repository/auth_repo.dart';

class AuthendicationProvider extends AuthRepository
    with CommonMethods, ChangeNotifier {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneloginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpKey = GlobalKey<FormState>();
  final authe = FirebaseAuth.instance;
  Validators validator = Validators();
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;
  User? user1;
  User? mobileuser;
  googleLogin(BuildContext context) async {
    showLoaderButton(context, "Please wait....");
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    } else {
      user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user1 = userCredential.user;
      addCustomer(
          user1!.displayName, user1!.email, user1!.uid, user1!.phoneNumber);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  phoneLogin(BuildContext context) {
    showLoaderButton(context, "Please wait....");
    authe.verifyPhoneNumber(
      phoneNumber: phone.text,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        print(e.toString());
      },
      codeSent: (String verificationId, int? token) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                      verificationId: verificationId,
                    )));
      },
      codeAutoRetrievalTimeout: (e) {
        print(e.toString());
      },
    );
  }

  otpVerify(BuildContext context, verificationId) async {
    showLoaderButton(context, "Please wait....");
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp.text);
    UserCredential userCredential =
        await authe.signInWithCredential(credential);
    mobileuser = userCredential.user;
    addCustomer(mobileuser!.displayName, mobileuser!.email, mobileuser!.uid,
        mobileuser!.phoneNumber);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  signOutFunc(BuildContext context) async {
    try {
      await authe.signOut();
      getSnackbar(context, "Successfully logged out");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseException catch (e) {
      back(context);
      getSnackbar(context, "${e.message}");
    }
    notifyListeners();
  }

  addCustomer(name, email, uid, phone) async {
   
    await addCustomerDetails(
        {"name": name, "email_id": email, "user_id": uid, "phone": phone});
  }
}
