import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kleber_bank/documents/documents.dart';
import 'package:kleber_bank/utils/app_const.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../main.dart';
import 'app_colors.dart';
import 'app_styles.dart';
import 'common_functions.dart';

class AppWidgets {
  static Widget textFieldLabel(String label, {bool isRequired = true}) {
    if (isRequired) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppStyles.c656262W500S18,
          ),
        ],
      );
    }
    return Text(
      label,
      textAlign: TextAlign.start,
      style: AppStyles.c656262W500S18,
    );
  }

  /*static void openDatePicker(BuildContext context, dynamic Function(Object?)? onSubmit, void Function()? onCancel,
      {DateRangePickerSelectionMode mode = DateRangePickerSelectionMode.range}) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Wrap(
          children: [
            SfDateRangePicker(
              view: DateRangePickerView.month,
              onSubmit: onSubmit,
              selectionMode: mode,
              monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
              ),
              showActionButtons: true,
              onCancel: onCancel,
            ),
          ],
        ),
      ),
    );
  }*/

  static Container divider() {
    return Container(
      color: AppColors.kViolate,
      height: 0.2,
    );
  }

  static Widget portfolioListElement(String label, String value, {String middleValue = ''}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.c656262W500S14,
        ),
        if (middleValue.isNotEmpty) ...{
          Text(
            middleValue,
            style: AppStyles.c656262W200S14,
          )
        },
        if (middleValue.isEmpty) ...{
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppStyles.c656262W200S14,
            ),
          )
        } else ...{
          Text(
            value,
            style: AppStyles.c656262W200S14,
          )
        },
      ],
    );
  }

  static Widget btn(String label, {double? width, double horizontalPadding = 0, Widget? widget, bool borderOnly = false, Color? bgColor}) {
    return Container(
      width: width,
      alignment: Alignment.center,
      decoration: gradiantDecoration(borderOnly: borderOnly, color: bgColor),
      padding: EdgeInsets.symmetric(vertical: rSize * 0.012, horizontal: horizontalPadding),
      child: Text(
        label,
        style: borderOnly ? AppStyles.c3C496CW500S18 : AppStyles.cFFFFFFW400S18.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  static Widget btnWithIcon(String label, Color bgColor, Widget icon) {
    return Container(
      alignment: Alignment.center,
      decoration: gradiantDecoration(borderOnly: false, color: bgColor),
      padding: EdgeInsets.symmetric(vertical: rSize * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            label,
            style: AppStyles.cFFFFFFW400S18.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static BoxDecoration gradiantDecoration({bool borderOnly = false, Color? color}) {
    return BoxDecoration(
        color: borderOnly ? Colors.transparent : color ?? AppColors.kViolate,
        /*gradient: LinearGradient(
            colors: [
              Color(0xFF4849BE),
              AppColors.appBarTitleColoe,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),*/
        border: Border.all(color: color ?? AppColors.kViolate, width: 1),
        borderRadius: BorderRadius.circular(10));
  }

  static Expanded sheetElement(String img, String label, void Function()? onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(rSize * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColors.kTextFieldInput, width: 1)),
                child: Image.asset(
                  'assets/$img',
                  scale: 25,
                )),
            SizedBox(
              height: rSize * 0.01,
            ),
            Text(
              label,
              style: AppStyles.c656262W500S16,
            )
          ],
        ),
      ),
    );
  }

  static void openMediaSelectionBottomSheet(BuildContext context, {required void Function()? onFileClick, required void Function()? onCameraClick}) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: rSize * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppWidgets.sheetElement(
                'media.png',
                'Select File',
                onFileClick,
              ),
              AppWidgets.sheetElement(
                'camera.png',
                'Capture Image',
                onCameraClick,
              ),
            ],
          ),
        );
      },
    );
  }

  static AppBar appBar(String title, {Widget? leading, List<Widget>? actions}) {
    return AppBar(
      elevation: 0,
      actions: actions,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: leading,
      title: Text(
        title,
        style: AppStyles.c656262W500S20,
      ),
      centerTitle: true,
    );
  }

  static Widget drawer(Function onItemClick) {
    List<String> titleList = ['Home', 'Portfolio', 'Market', 'Proposal', 'Documents', 'Profile'];
    return Container(
      color: AppColors.bg,
      width: rSize * 0.35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: rSize * 0.15,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: rSize * 0.015, vertical: rSize * 0.02),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0, // how wide the shadow is spread
                    blurRadius: 3, // how blurry the shadow is
                    offset: Offset(0, 0),
                  ),
                ], color: AppColors.kViolate, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                child: Column(
                  children: [
                    SizedBox(
                      height: rSize * 0.015,
                    ),
                    Text(
                      'John Wick',
                      style: AppStyles.cFFFFFFW400S18,
                    ),
                    Text(
                      'johnwick@gmail.com',
                      style: AppStyles.cFFFFFFW400S18,
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.only(
                  top: rSize * 0.01,
                  left: rSize * 0.015,
                  right: rSize * 0.015,
                ),
                color: Colors.white,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: titleList.length,
                  padding: EdgeInsets.only(
                    left: rSize * 0.015,
                    right: rSize * 0.015,
                    bottom: rSize * 0.015,
                    top: rSize * 0.04,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (titleList[index] == 'Documents') {
                          CommonFunctions.navigate(context, Documents());
                        }
                        if (titleList[index] == 'Profile') {
                          onItemClick(4);
                        } else {
                          onItemClick(index);
                        }
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/${titleList[index].toLowerCase()}.png',
                            scale: 25,
                            color: AppColors.kTextFieldInput,
                          ),
                          SizedBox(
                            width: rSize * 0.015,
                          ),
                          Expanded(
                            child: Text(
                              titleList[index],
                              style: AppStyles.c656262W500S18,
                            ),
                          ),
                          RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.kTextFieldInput,
                                size: 15,
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: AppColors.kTextFieldInput,
                      margin: EdgeInsets.symmetric(vertical: rSize * 0.01),
                      height: 0.5,
                    );
                  },
                ),
              ),
              Expanded(child: SizedBox()),
              Text(
                'Version 1.0.0',
                style: AppStyles.c656262W500S18,
              ),
              SizedBox(
                height: rSize * 0.015,
              )
            ],
          ),
          Positioned(
            top: rSize * 0.1,
            child: const CircleAvatar(
              child: Icon(Icons.face),
              radius: 40,
            ),
          ),
        ],
      ),
    );
  }

  static dropDownIcon() {
    return const Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Color(0xff8B8B8B),
    );
  }

  static Widget dropDownHint(String text) {
    return Text(
      textAlign: TextAlign.start,
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppStyles.c656262W500S18,
    );
  }

  static showAlert(BuildContext context, String msg, String label1, String label2, void Function()? onTap1, void Function()? onTap2) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(rSize * 0.04),
            child: Wrap(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: rSize*0.02,),
                        Text(
                          msg,
                          style: AppStyles.c3C496CW500S18,
                        ),
                        SizedBox(height: rSize*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(onTap: onTap1, child: btn(label1, borderOnly: true, horizontalPadding: rSize * 0.02)),
                            SizedBox(width: rSize*0.02,),
                            GestureDetector(onTap: onTap2, child: btn(label2, horizontalPadding: rSize * 0.02)),
                          ],
                        ),
                        SizedBox(height: rSize*0.02,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void openDatePicker(BuildContext context, dynamic Function(Object?)? onSubmit, void Function()? onCancel,
      {DateRangePickerSelectionMode mode = DateRangePickerSelectionMode.range}) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Wrap(
          children: [
            SfDateRangePicker(
              view: DateRangePickerView.month,
              onSubmit: onSubmit,
              selectionMode: mode,
              monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
              ),
              showActionButtons: true,
              onCancel: onCancel,
            ),
          ],
        ),
      ),
    );
  }
}
