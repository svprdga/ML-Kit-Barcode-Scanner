package com.svprdga.ml_kit_barcode_scanner

import android.util.Log
import androidx.annotation.NonNull
import com.google.mlkit.vision.barcode.Barcode
import com.google.mlkit.vision.barcode.BarcodeScannerOptions
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.common.InputImage

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONArray

private const val TAG = "MlKitBarcodeScanner"

private const val NATIVE_SCAN_BYTE_ARRAY = "scan_byte_array"
private const val ERROR_SCAN_BYTE_ARRAY = "error_$NATIVE_SCAN_BYTE_ARRAY"

class MlKitBarcodeScannerPlugin : FlutterPlugin, MethodCallHandler {

    // ****************************************** VARS ***************************************** //

    private lateinit var channel: MethodChannel
    private val scanner = BarcodeScanning.getClient()
    private val barcodeParser = BarcodeParser()

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

    private fun scanByteArray(@NonNull call: MethodCall, @NonNull result: Result) {
        // Get arguments
        val args = call.arguments as ArrayList<Any>
        val bytes = args[0] as ByteArray
        val width = args[1] as Double
        val height = args[2] as Double
        val rotation = args[3] as Int


        // Prepare InputImage
        val image = InputImage.fromByteArray(
            bytes, width.toInt(), height.toInt(), rotation, InputImage.IMAGE_FORMAT_NV21
        )

        // Process image
        scanner.process(image)
            .addOnSuccessListener { barcodes ->
                result.success(processBarcodes(barcodes).toString())
            }
            .addOnFailureListener {
                result.error(ERROR_SCAN_BYTE_ARRAY, "Could not scan image", null)
            }
    }

    private fun processBarcodes(barcodes: List<Barcode>): JSONArray {
        val array = JSONArray()

        for (barcode in barcodes) {
            try {
                array.put(barcodeParser.parseBarcode(barcode))
            } catch (e: Exception) {
               Log.e(TAG, "Could not parse one of the detected barcodes, cause: $e")
            }
        }

        return array
    }
}
