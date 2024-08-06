import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier{
  bool hideCurrentPwd=true,hideNewPwd=true,hideConfirmNewPwd=true;
  TextEditingController
  currentPwdController=TextEditingController(),
  newPwdController=TextEditingController(),
  confirmNewPwdController=TextEditingController();

  var selectedLanguage=0;

  void changeCurrentPwdVisibilityStatus(){
    hideCurrentPwd=!hideCurrentPwd;
    notifyListeners();
  }

  void changeNewPwdVisibilityStatus(){
    hideNewPwd=!hideNewPwd;
    notifyListeners();
  }

  void changeConfirmNewPwdVisibilityStatus(){
    hideConfirmNewPwd=!hideConfirmNewPwd;
    notifyListeners();
  }

  void changeLanguage(int language) {
    selectedLanguage=language;
    notifyListeners();
  }
}