package com.yinxin.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.yinxin.app/printer"
    private lateinit var printerDiscovery: PrinterDiscovery

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        printerDiscovery = PrinterDiscovery(this)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "discoverPrinters" -> {
                        printerDiscovery.discover { printers ->
                            runOnUiThread {
                                result.success(printers)
                            }
                        }
                    }
                    "stopDiscovery" -> {
                        printerDiscovery.stop()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
