import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kleber_bank/login/user_info_model.dart';
import 'package:kleber_bank/utils/app_const.dart';
import 'package:kleber_bank/utils/shared_pref_utils.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_widgets.dart';
import 'login_controller.dart';

class OTPScreen extends StatefulWidget {
  final Map<String, dynamic>? map;

  const OTPScreen(this.map, {super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late LoginController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserInfotModel model;

  @override
  void initState() {
    model = AppConst.userModel!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<LoginController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/login_bg.jpg"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SizedBox(
              height: rSize * 0.1,
            ),
            Image.asset(
              "assets/logo.png",
              scale: 2,
            ),
            const Expanded(child: SizedBox()),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: rSize * 0.03, horizontal: rSize * 0.01),
              elevation: 2,
              child: Padding(
                padding:
                    EdgeInsets.only(left: rSize * 0.02, right: rSize * 0.02, top: rSize * 0.03, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image.asset('assets/logo.png',scale: 2,),

                        if (widget.map != null) ...{
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  (model.user?.firstName ?? 'FirstName (N/A)') + ' ' + (model.user?.firstName ?? 'LastName (N/A)'),
                                  style: AppStyles.c656262W500S16,
                                ),
                                Text(widget.map!['location'], style: AppStyles.c656262W200S14),
                              ],
                            ),
                          )
                        },
                        if (model.verification == 'authentification') ...{
                          Text(
                            'Enter the code from your authenticator app',
                            style: AppStyles.c656262W500S16,
                          ),
                        },
                        SizedBox(
                          height: rSize * 0.02,
                        ),
                        Text(
                          'Enter Code',
                          style: AppStyles.c656262W500S16,
                        ),
                        SizedBox(
                          height: rSize * 0.02,
                        ),
                        Wrap(
                          spacing: rSize * 0.01,
                          children: [
                            otpWidget(
                              _controller.otpController1,
                              _controller.focusNode1,
                              (p0) {
                                if (p0.length == 1) {
                                  FocusScope.of(context).requestFocus(_controller.focusNode2);
                                }
                              },
                            ),
                            otpWidget(
                              _controller.otpController2,
                              _controller.focusNode2,
                              (p0) {
                                if (p0.length == 1) {
                                  FocusScope.of(context).requestFocus(_controller.focusNode3);
                                }
                              },
                            ),
                            otpWidget(
                              _controller.otpController3,
                              _controller.focusNode3,
                              (p0) {
                                if (p0.length == 1) {
                                  FocusScope.of(context).requestFocus(_controller.focusNode4);
                                }
                              },
                            ),
                            otpWidget(
                              _controller.otpController4,
                              _controller.focusNode4,
                              (p0) {
                                if (p0.length == 1) {
                                  FocusScope.of(context).requestFocus(_controller.focusNode5);
                                }
                              },
                            ),
                            otpWidget(
                              _controller.otpController5,
                              _controller.focusNode5,
                              (p0) {
                                if (p0.length == 1) {
                                  FocusScope.of(context).requestFocus(_controller.focusNode6);
                                }
                              },
                            ),
                            otpWidget(
                              _controller.otpController6,
                              _controller.focusNode6,
                              (p0) {
                                if (p0.length == 1) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: rSize * 0.01,
                        ),
                        GestureDetector(
                            onTap: () {
                              _controller.reSend(context);
                            },
                            child: Text(
                              'Resend',
                              style: AppStyles.c3C496CW500S16.copyWith(decoration: TextDecoration.underline),
                            )),
                        SizedBox(
                          height: rSize * 0.02,
                        ),
                        InkWell(
                            onTap: () async {
                              // showQR('key');
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                _controller.verify(context, (key) {
                                  showQR(key, () {
                                    Navigator.pop(context);
                                    model.verification = 'authentification';
                                    _controller.refresh();
                                  });
                                });
                              }
                            },
                            child: AppWidgets.btn('Verify')),
                        SizedBox(
                          height: rSize * 0.03,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox otpWidget(TextEditingController controller, FocusNode focusNode, void Function(String) onChanged) {
    return SizedBox(
      width: rSize * 0.05,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        maxLength: 1,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return '';
          }
        },
        keyboardType: TextInputType.number,
        decoration: AppStyles.inputDecoration(context,label: '', counterText: ''),
      ),
    );
  }

  void showQR(String key, Function onNextClick) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return Future(
              () => false,
            );
          },
          child: Center(
            child: Wrap(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(rSize * 0.015),
                    child: Column(
                      children: [
                        SizedBox(
                          height: rSize * 0.01,
                        ),
                        Text(
                          'Scan below Qr code using authenticator app',
                          style: AppStyles.c3C496CW500S16,
                        ),
                        SizedBox(
                          height: rSize * 0.01,
                        ),
                        QrImageView(
                          data: 'otpauth://totp/InvestGlass?secret=$key&issuer=InvestGlass',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        SizedBox(
                          height: rSize * 0.015,
                        ),
                        GestureDetector(
                            onTap: () {
                              onNextClick();
                            },
                            child: AppWidgets.btn('Next')),
                        SizedBox(
                          height: rSize * 0.01,
                        ),
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
}
