import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToasts {
  AppToasts._();

  static void longToast(message, {ToastGravity? gravity}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12,
    );
  }

  static void shortToast(message, {ToastGravity? gravity}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12,
    );
  }
}
