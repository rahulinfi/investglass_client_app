import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'app_colors.dart';
import 'app_widgets.dart';

class AppStyles {
  static double px15 = rSize * 0.015;
  static double px16 = rSize * 0.016;
  static double px22 = rSize * 0.0205;
  static double px28 = rSize * 0.027;

  static double px12 = rSize * 0.012;
  static double px14 = rSize * 0.014;
  static double px18 = rSize * 0.018;
  static double px20 = rSize * 0.020;

  // static TextStyle c333333W400S12 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px12, color: AppColors.kDateTimeColor);
  static TextStyle c656262W500S18 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px18, color: AppColors.kTextFieldInput);
  static TextStyle c656262W400S16 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px16, color: AppColors.kTextFieldInput);
  static TextStyle c656262W200S16 = GoogleFonts.rubik(fontWeight: FontWeight.w200, fontSize: px16, color: AppColors.kTextFieldInput);
  static TextStyle c656262W200S14 = GoogleFonts.rubik(fontWeight: FontWeight.w200, fontSize: px14, color: AppColors.kTextFieldInput);
  static TextStyle c656262W400S18 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px18, color: AppColors.kTextFieldInput);
  static TextStyle c656262W400S20 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px20, color: AppColors.kTextFieldInput);
  static TextStyle c656262W500S16 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px16, color: AppColors.kTextFieldInput);
  static TextStyle c656262W500S20 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px20, color: AppColors.kTextFieldInput);
  static TextStyle c3C496CW500S18 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px18, color: AppColors.kViolate);
  static TextStyle c3C496CW500S16 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px16, color: AppColors.kViolate);
  static TextStyle c3C496CW400S14 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px14, color: AppColors.kViolate);
  static TextStyle c656262W500S14 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px14, color: AppColors.kTextFieldInput);
  static TextStyle c929292W500S14 = GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: px14, color: AppColors.kHint);
  static TextStyle cFFFFFFW400S18 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px18, color: Colors.white);
  static TextStyle cFFFFFFW400S16 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px16, color: Colors.white);
  static TextStyle cRedW400S18 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px18, color: Colors.redAccent);
  static TextStyle errorStyle = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px18, color: AppColors.kErrorBorderColor,);
  static TextStyle errorStyle16 = GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: px16, color: AppColors.kErrorBorderColor);



  static InputDecoration dropDownInputDecoration(Widget? label) {
    return InputDecoration(
      label: label,
      errorStyle: AppStyles.cRedW400S18,

      hintStyle: AppStyles.c656262W500S18,
      contentPadding: EdgeInsets.all(15.0),
      // Inside box padding
      border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kErrorBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kErrorBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  static InputDecoration inputDecoration(
      {String? hint,
      String? label,
      String? counterText,
      Widget? prefix,
      Widget? suffix,
      String? preffixText,
      // TextStyle? hintStyle,
      EdgeInsetsGeometry? contentPadding,
      Color? borderColor}) {
    return InputDecoration(
      hintText: hint,
      label: AppWidgets.textFieldLabel(label??''),
      counterText: counterText,
      // counterStyle: c002055W500S12.copyWith(color: Color(0XFFDCD9D9)),
      prefix: prefix,
      suffix: suffix,prefixText: preffixText,
      errorStyle: errorStyle,

      hintStyle: c929292W500S14,
      contentPadding: contentPadding ?? EdgeInsets.all(rSize * 0.013),
      // Inside box padding
      border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.kBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.kBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.kBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kErrorBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kErrorBorderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
