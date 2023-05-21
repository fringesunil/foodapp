import 'package:flutter/material.dart';

mixin CommonMethods {
   back(BuildContext context) {
    Navigator.pop(context);
  }

  void showLoaderButton(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  getSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.lightGreen,
      content: Text(
        message,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black
               ),
      ),
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }

}
