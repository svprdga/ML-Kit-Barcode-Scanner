package com.svprdga.ml_kit_barcode_scanner

import android.content.Context
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import com.google.mlkit.vision.barcode.Barcode
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.common.InputImage

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONArray

private const val TAG = "MlKitBarcodeScanner"

private const val NATIVE_SCAN_INPUT_IMAGE = "scan_input_image"
private const val ERROR_SCAN_INPUT_IMAGE = "error_$NATIVE_SCAN_INPUT_IMAGE"

private const val INPUT_IMAGE_TYPE_BYTE_ARRAY = 0
private const val INPUT_IMAGE_TYPE_URI = 1

class MlKitBarcodeScannerPlugin : FlutterPlugin, MethodCallHandler {

    // ****************************************** VARS ***************************************** //

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val scanner = BarcodeScanning.getClient()
    private val barcodeParser = BarcodeParser()

    // ************************************* PUBLIC METHODS ************************************ //

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ml_kit_barcode_scanner")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            NATIVE_SCAN_INPUT_IMAGE -> scanInputImage(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ************************************ PRIVATE METHODS ************************************ //

    private fun scanInputImage(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        // Get arguments
        val args = call.arguments as ArrayList<Any>
        val type = args[0] as Int
        val bytes = args[1] as ByteArray?
        val width = args[2] as Int?
        val height = args[3] as Int?
        val rotation = args[4] as Int?
        val uri = args[5] as String?

        // Prepare InputImage
        val image = when (type) {
            INPUT_IMAGE_TYPE_BYTE_ARRAY -> {
                InputImage.fromByteArray(
                    bytes, width!!, height!!, rotation!!, InputImage.IMAGE_FORMAT_NV21
                )
            }
            INPUT_IMAGE_TYPE_URI -> {
                InputImage.fromFilePath(context, Uri.parse(uri!!))
            }
            else -> {
                result.error(ERROR_SCAN_INPUT_IMAGE, "Unrecognized type of InputImage", null)
                throw Exception()
            }
        }

        // Process image
        scanner.process(image)
            .addOnSuccessListener { barcodes ->
                result.success(processBarcodes(barcodes).toString())
            }
            .addOnFailureListener {
                result.error(ERROR_SCAN_INPUT_IMAGE, "Could not scan image", null)
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
