import 'package:flutter/cupertino.dart';

class LocalizationsUtil {
  String locale;

  static LocalizationsUtil of(BuildContext context){
    return Localizations.of<LocalizationsUtil>(context, LocalizationsUtil);
  }

//  String get
}