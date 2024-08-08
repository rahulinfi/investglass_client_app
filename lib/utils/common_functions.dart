import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'dart:math' as math;

class CommonFunctions{

  static showToast(String msg,{bool success=false}){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: success?Colors.green:Colors.redAccent,
      textColor: Colors.white,
    );
  }

  static showLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: const Center(child: CircularProgressIndicator())),
    );
  }

  static dismissLoader(BuildContext context) {
    Navigator.pop(context);
  }

  static navigate(BuildContext context, Widget screen,
      {bool removeCurrentScreenFromStack = false,
        bool removeAllScreensFromStack = false,
        Function? onBack}) {
    if (removeCurrentScreenFromStack) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          )).then((value) {
        if (onBack != null) {
          onBack(value);
        }
      });
    } else if (removeAllScreensFromStack) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => screen),
              (Route<dynamic> route) => false);
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ).then((value) {
        if (onBack != null) {
          onBack(value);
        }
      });
    }
  }

  static bool compare(String searchedWord,String text){
    return text.toLowerCase().replaceAll(' ', '').contains(searchedWord.toLowerCase().replaceAll(' ', ''));
  }

  static String getYYYYMMDD(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDoubleWithThousandSeperator(
      String doubleStr,
      bool hideDecimalIfIs0,
      int numberOfDecimal,
      ) {
    final value = double.tryParse(doubleStr.replaceAll(',', '')) ?? 0;
    if (value != 0 && value ~/ math.pow(10, 15) > 0) {
      return value.toStringAsPrecision(15);
    }
    String decimalStr = '';
    for (var i = 0; i < numberOfDecimal; i++) {
      decimalStr += (hideDecimalIfIs0 ? '#' : '0');
    }
    NumberFormat formatter = NumberFormat('#,##0.${decimalStr}', 'en_US');
    return formatter.format(value);
  }
}