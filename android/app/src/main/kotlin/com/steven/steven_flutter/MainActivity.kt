package com.steven.steven_flutter

import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    var C_NAME = "samples.flutter.study/call_native"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val methodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.jk/battery");
        methodChannel.setMethodCallHandler { call, result ->
            //如果等于flutter中传过来的方法名称
            if (call.method.equals("getBatteryInfo")) {
                //调用另外一个自定义方法回去电量信息
                val batteryLevel = getBatteryLevel();
                if (batteryLevel != -1) {
                    result.success(batteryLevel);
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null);
                }
            } else {
                //如果没有这个方法名称就返回没有这个接口
                result.notImplemented();
            }
        }
    }

    private fun getBatteryLevel(): Int {
        var batteryLevel = -1

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {

            val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager

            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);

        } else {

            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            );

            batteryLevel = (intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                ?.times(100))?.div((intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1))) ?: 0
        }
        return batteryLevel;
    }
}
