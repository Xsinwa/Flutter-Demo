import 'package:flutter/services.dart';

class SharedPreferencesUtil {
  static const _platform =
      const MethodChannel("com.mrper.framework.plugins/shared_preferences");

  static void set(String key, var value) =>
      _platform.invokeMethod("set", {"key": key, "value": value});

  static Future<dynamic> get(String key, var defaultValue) async{
    var result;
    try {
      result = await _platform.invokeMethod("get", {"key" : key, "default" : defaultValue});
    }on PlatformException catch(e){
      print(e.toString());
    }
    return result;
  }
}
