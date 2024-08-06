import 'package:flutter/cupertino.dart';

class PortfolioController extends ChangeNotifier{
  int selectedIndex=-1;
  int selectedPositionIndex=-1;
  int selectedTransactionIndex=-1;
  String selectedPositionFilter='Largest Weight';

  var positionsFilterTypeList=['Largest Weight','Smallest Weight', 'Best Performance','Worst Performance','A-Z','Z-A',];

  selectIndex(int index) {
    if (selectedIndex!=index) {
      selectedIndex=index;
    }else{
      selectedIndex=-1;
    }
    notifyListeners();
  }

  selectPositionIndex(int index) {
    if (selectedPositionIndex!=index) {
      selectedPositionIndex=index;
    }else{
      selectedPositionIndex=-1;
    }
    notifyListeners();
  }

  selectTransactionIndex(int index) {
    if (selectedTransactionIndex!=index) {
      selectedTransactionIndex=index;
    }else{
      selectedTransactionIndex=-1;
    }
    notifyListeners();
  }

  void selectPositionFilter(String value) {
    selectedPositionFilter=value;
    notifyListeners();
  }
}