import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_widgets.dart';
import '../utils/flutter_flow_theme.dart';
import 'login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<LoginController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            stops: const [0.0, 0.4],
            begin: const AlignmentDirectional(0.0, -1.0),
            end: const AlignmentDirectional(0, 1.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: rSize * 0.1,
            ),
            Image.asset(
              Theme.of(context).brightness == Brightness.dark ? 'assets/white-investglass.png' : 'assets/logo.png',
              width: rSize * 0.17,
              height: rSize * 0.05,
              fit: BoxFit.contain,
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
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                          },
                          decoration: AppStyles.inputDecoration(context,
                              label: 'User ID',
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              labelStyle:FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Roboto',
                                letterSpacing: 0.0,
                              ),
                              suffix: Icon(
                                Icons.account_circle_outlined,
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                size: 25.0,
                              )),
                        ),
                        SizedBox(
                          height: rSize * 0.08,
                        ),
                        TextFormField(
                          controller: _controller.pwdController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                          },
                          obscureText: _controller.hidePwd,
                          decoration: AppStyles.inputDecoration(context,
                              label: 'Password',
                              labelStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              suffix: GestureDetector(
                                  onTap: () {
                                    _controller.changeVisibility();
                                  },
                                  child: Icon(_controller.hidePwd ? Icons.visibility : Icons.visibility_off))),
                        ),
                        SizedBox(
                          height: rSize * 0.06,
                        ),
                        InkWell(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                _controller.doLogin(context);
                              }
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
