import 'package:flutter/material.dart';


class TabManager extends ChangeNotifier{
  int selectedTab = 0;

  void goToRecipes(){
    selectedTab = 1;
    notifyListeners();

  }
  void goToTab(index){
    selectedTab = index;
    notifyListeners();

  }
}