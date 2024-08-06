import 'package:flutter/material.dart';

class ProposalController extends ChangeNotifier{
  int selectedIndex=-1;

  var typesList=['All','Portfolio Proposal'];
  selectTransactionIndex(int index) {
    if (selectedIndex!=index) {
      selectedIndex=index;
    }else{
      selectedIndex=-1;
    }
    notifyListeners();
  }

}