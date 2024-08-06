import 'package:flutter/cupertino.dart';
import 'package:kleber_bank/login/otp_screen.dart';

import '../dashboard/dashboard.dart';
import '../utils/api_calls.dart';
import '../utils/common_functions.dart';

class LoginController extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController(), pwdController = TextEditingController();
  bool hidePwd=true;

  Future<void> doLogin(BuildContext context) async {
    CommonFunctions.navigate(context, OTPScreen());
    /*CommonFunctions.showLoader(context);
    await ApiCalls.login(userNameController.text, pwdController.text).then(
      (value) {
        CommonFunctions.dismissLoader(context);
        if (value) {
          CommonFunctions.navigate(context, Dashboard());
        }
      },
    );
    notifyListeners();*/
  }

  void changeVisibility() {
    hidePwd=!hidePwd;
    notifyListeners();
  }
}
