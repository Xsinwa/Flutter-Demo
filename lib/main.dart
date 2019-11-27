import 'package:flutter/material.dart';
import 'package:flutter_app/entity/ColorsModel.dart';
import 'package:flutter_app/page/CreateMissionPage.dart';
import 'package:flutter_app/store/Index.dart';
import 'package:flutter_app/entity/SharedValuesModel.dart';
import 'package:flutter_app/page/LanguagePage.dart';
import 'package:flutter_app/page/LoginPage.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_app/page/SettingPage.dart';
import 'package:flutter_app/page/ThemePage.dart';
import 'package:flutter_app/utils/SharedPreferencesUtil.dart';


void main() {
  runApp(Store.init(child: MyApp()));
  /// Android沉浸状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initSetting(context);

    return Store.connect<SharedValuesModel>(
      builder: (context, child, model){
        return MaterialApp(
          //去掉debug标志
          debugShowCheckedModeBanner: false,
          title: '任务闹铃',
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
            "page_create_mission": (context) => CreateMissionPage(),
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

  /// 初始化设置参数
  void initSetting(BuildContext context){
    /// 获取缓存主题
    Future<dynamic> theme = SharedPreferencesUtil.get("theme", 0);
    theme.then((dynamic index){
      /// 将缓存值传给ThemeConfigModel
      Store.value<SharedValuesModel>(context).setTheme(ColorsModel.colors[index]);
    });
    /// 获取设置缓存
    Future<dynamic> openRemind = SharedPreferencesUtil.get("openRemind", false);
    openRemind.then((dynamic isOpen){
      /// 将缓存值传给ThemeConfigModel
      Store.value<SharedValuesModel>(context).setOpenRemind(isOpen);
    });
  }
}
