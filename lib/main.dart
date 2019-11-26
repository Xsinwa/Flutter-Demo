import 'package:flutter/material.dart';
import 'package:flutter_app/store/Index.dart';
import 'package:flutter_app/entity/ThemeConfigModel.dart';
import 'package:flutter_app/page/LanguagePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_app/page/SettingPage.dart';
import 'package:flutter_app/page/ThemePage.dart';


void main() {
  runApp(Store.init(child: MyApp()));
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Store.connect<ThemeConfigModel>(
      builder: (context, child, model){
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: model.theme,
          ),
          //注册路由表
          routes: {
            "page_home": (context) => HomePage(),
            "page_login": (context) => LoginPage(),
            "page_setting": (context) => SettingPage(),
            "page_language": (context) => LanguagePage(),
            "page_theme": (context) => ThemePage(),
          },
//      onGenerateRoute: (RouteSettings settings){
//        return MaterialPageRoute(builder: (context){
//          String routeName = settings.name;
//          print("路由名：$routeName");
//        });
//      },
          home: LoginPage(),
        );
      }
    );
  }
}
