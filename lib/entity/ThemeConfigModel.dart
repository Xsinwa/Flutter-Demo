import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  Color theme = Colors.deepPurple;
}

class ThemeConfigModel extends ThemeConfig with ChangeNotifier{
  Future setTheme(load) async{
    theme = load;
    notifyListeners();
  }
}