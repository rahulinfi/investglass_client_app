
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_widgets.dart';
import 'login_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late LoginController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<LoginController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/login_bg.jpg"),fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            SizedBox(height: rSize*0.1,),
            Image.asset("assets/logo.png",scale: 2,),
            const Expanded(child: SizedBox()),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: rSize * 0.03, horizontal: rSize * 0.01),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.only(left: rSize * 0.02,right: rSize * 0.02, top: rSize * 0.03,bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _formKey,
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset('assets/logo.png',scale: 2,),
                        SizedBox(
                          height: rSize * 0.08,
                        ),
                        TextFormField(
                          controller: _controller.userNameController,
                          validator: (value) {
                            if(value==null || value.isEmpty){
                              return 'Required';
                            }
                          },
                          decoration: AppStyles.inputDecoration(label: 'User ID', suffix: Icon(Icons.remove_red_eye_rounded,color: Colors.transparent,)),
                        ),
                        SizedBox(
                          height: rSize * 0.08,
                        ),
                        TextFormField(
                          controller: _controller.pwdController,
                          validator: (value) {
                            if(value==null || value.isEmpty){
                              return 'Required';
                            }
                          },
                          obscureText: _controller.hidePwd,
                          decoration: AppStyles.inputDecoration(label: 'Password', suffix: GestureDetector(
                              onTap: () {
                                  _controller.changeVisibility();
                              },
                              child: Icon(_controller.hidePwd? Icons.visibility
                                  : Icons.visibility_off))),
                        ),
                        SizedBox(
                          height: rSize * 0.07,
                        ),
                        Text(
                          'Forgot Password',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            fontSize: AppStyles.px18,
                            color: AppColors.kViolate,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: rSize * 0.06,
                        ),
                        InkWell(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // if(_formKey.currentState!.validate()){
                                _controller.doLogin(context);
                              // }
                            },
                            child: AppWidgets.btn('Login')),
                        SizedBox(
                          height: rSize * 0.08,
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
}
