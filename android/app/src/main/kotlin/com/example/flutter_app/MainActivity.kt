package com.example.flutter_app

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.SharedPreferencesPlugin
import io.flutter.plugins.ToastProviderPlugin

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        ToastProviderPlugin.getInstance().register(this, flutterView)
        SharedPreferencesPlugin.getInstance().register(this, flutterView)
    }
}
