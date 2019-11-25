import 'package:flutter/services.dart';

class ToastUtil {

  static const _platform = const MethodChannel("com.mrper.framework.plugins/toast");

  static void showShortToast(String message) =>
      _platform.invokeMethod("showShortToast", { "message": message});

  static void showLongToast(String message) =>
      _platform.invokeMethod("showLongToast", { "message": message});

  static void showToast(String message, int duration) =>
      _platform.invokeMethod(
          "showToast", { "message": message, "duration": duration});

}