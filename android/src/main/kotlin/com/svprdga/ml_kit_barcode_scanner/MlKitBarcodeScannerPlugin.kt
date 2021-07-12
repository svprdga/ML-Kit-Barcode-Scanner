package com.svprdga.ml_kit_barcode_scanner

import android.util.Log
import androidx.annotation.NonNull
import com.google.mlkit.vision.barcode.BarcodeScannerOptions

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

private const val NATIVE_SCAN_BYTE_ARRAY = "scan_byte_array"

class MlKitBarcodeScannerPlugin: FlutterPlugin, MethodCallHandler {

  // ****************************************** VARS ***************************************** //

  private lateinit var channel : MethodChannel

  // ************************************* PUBLIC METHODS ************************************ //

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ml_kit_barcode_scanner")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      NATIVE_SCAN_BYTE_ARRAY -> scanByteArray(call, result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  // ************************************ PRIVATE METHODS ************************************ //

  private fun scanByteArray(@NonNull call:MethodCall, @NonNull result: Result) {
    val bytes = call.arguments as ByteArray
    Log.d("blur", "the byte array: ${bytes.size}")
    result.success(null)
  }
}
