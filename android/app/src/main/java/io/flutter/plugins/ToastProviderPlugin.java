package io.flutter.plugins;

import android.content.Context;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

/**
 * @Description:
 * @Author:xhxie2
 * @Date:2019-11-22
 */
public class ToastProviderPlugin {
    private static final String channelName = "com.mrper.framework.plugins/toast";
    private static ToastProviderPlugin instance;
    private ToastProviderPlugin(){

    }

    public static ToastProviderPlugin getInstance(){
        if (null == instance){
            synchronized (ToastProviderPlugin.class){
                if (null == instance){
                    instance = new ToastProviderPlugin();
                }
            }
        }
        return instance;
    }

    /**
     * 注册插件
     * @param context 上下文
     * @param flutterView flutter界面
     */
    public  void register(Context context, FlutterView flutterView){
        new MethodChannel(flutterView, channelName).setMethodCallHandler((methodCall, result) -> {
            switch (methodCall.method){
                case "showShortToast":
                    showToast(context, methodCall.argument("message"), Toast.LENGTH_SHORT);
                    break;

                case "showLongToast":
                    showToast(context, methodCall.argument("message"), Toast.LENGTH_LONG);
                    break;

                case "showToast":
                    showToast(context, methodCall.argument("message"), methodCall.argument("duration"));
                    break;
            }
            result.success(null);
        });
    }

    /**
     * 展示toast
     * @param context
     * @param message
     * @param duration
     */
    private void showToast(Context context, String message, int duration){
        Toast.makeText(context, message, duration).show();
    }
}
