import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SharedValues {
  Color theme = Colors.deepPurple;
  bool openRemind = false;
}

class SharedValuesModel extends SharedValues with ChangeNotifier{
  Future setTheme(load) async{
    theme = load;
    notifyListeners();
  }

  Future setOpenRemind(isOpen) async{
    openRemind = isOpen;
    notifyListeners();
  }
}