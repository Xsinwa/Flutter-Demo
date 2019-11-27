package io.flutter.plugins;

import android.content.Context;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import utils.SharedPreferencesUtil;

/**
 * @Description:
 * @Author:xhxie2
 * @Date:2019-11-27
 */
public class SharedPreferencesPlugin {
    private static final String channelName = "com.mrper.framework.plugins/shared_preferences";
    private static SharedPreferencesPlugin instance;
    private Object data = null;

    private SharedPreferencesPlugin(){
    }

    public static SharedPreferencesPlugin getInstance(){
        if (null == instance){
            instance = new SharedPreferencesPlugin();
        }
        return instance;
    }

    public void register(Context context, FlutterView flutterView){
        new MethodChannel(flutterView, channelName).setMethodCallHandler((methodCall, result) -> {
            switch (methodCall.method){
                case "set":
                    SharedPreferencesUtil.put(context, methodCall.argument("key"), methodCall.argument("value"));
                    break;
                case "get":
                    data = SharedPreferencesUtil.get(context, methodCall.argument("key"), methodCall.argument("default"));
                    break;
            }
            result.success(data);
        } );
    }
}
