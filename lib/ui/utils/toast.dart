import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

const Duration LENGTH_SHORT = Duration(milliseconds: 2000);
const Duration LENGTH_LONG = Duration(milliseconds: 3500);

void toastLong(dynamic msg) {
  toast(msg, LENGTH_LONG);
}

void toast(dynamic msg, [Duration duration = LENGTH_SHORT]) {
  showToast(
    msg.toString(),
    duration: duration,
    position: ToastPosition.bottom,
    textPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    radius: 20,
    backgroundColor: Color(0xffeeeeee),
    textStyle: TextStyle(
      color: (msg is Exception) ? Colors.red : Colors.black,
    ),
  );
}
