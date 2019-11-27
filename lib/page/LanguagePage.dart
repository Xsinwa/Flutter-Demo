import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget{

   @override
  Widget build(BuildContext context) {
     var color = Theme.of(context).primaryColor;
     Locale locale = Localizations.localeOf(context);
     String type = locale.countryCode + "_" + locale.languageCode;

   Widget _languageItem(String lan, value){
      return ListTile(
        title: Text(lan, style: TextStyle(color: type == value ? color : null),),
        trailing: type == value ? Icon(Icons.done, color: color) : null,
        onTap: (){
            type = value;
        },
      );
   }
    return Scaffold(
      appBar: AppBar(
        title: Text("语言"),
      ),
      body: ListView(
        children: <Widget>[
          _languageItem("中文简体", "zh_CN"),
          _languageItem("English", "en_US"),
          _languageItem("系统语言", null),
        ],
      ),
    );
  }
}