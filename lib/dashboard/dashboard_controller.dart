import 'package:flutter/cupertino.dart';

class DashboardController extends ChangeNotifier{
  int selectedIndex=0;

  void changeIndex(int value) {
    selectedIndex=value;
    notifyListeners();
  }
}