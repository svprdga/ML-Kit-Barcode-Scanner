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
import java.io.File
import java.io.FileNotFoundException
import java.io.IOException

private const val TAG = "MlKitBarcodeScanner"

private const val NATIVE_SCAN_INPUT_IMAGE = "scan_input_image"
private const val ERROR_SCAN_INPUT_IMAGE_INVALID_ARGUMENTS =
    "error_${NATIVE_SCAN_INPUT_IMAGE}_invalid_arguments"
private const val ERROR_SCAN_INPUT_IMAGE_PARSE_URI = "error_${NATIVE_SCAN_INPUT_IMAGE}_parse_uri"
private const val ERROR_SCAN_INPUT_IMAGE_FILE_NOT_FOUND =
    "error_${NATIVE_SCAN_INPUT_IMAGE}_file_not_found"
private const val ERROR_SCAN_INPUT_IMAGE_UNKNOWN_TYPE =
    "error_${NATIVE_SCAN_INPUT_IMAGE}_unknown_type"
private const val ERROR_SCAN_INPUT_IMAGE_PROCESS_FAILURE =
    "error_${NATIVE_SCAN_INPUT_IMAGE}_process_failure"

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
        val path = args[6] as String?

        // Check arguments
        val checkByteArray =
            type == INPUT_IMAGE_TYPE_BYTE_ARRAY && (bytes == null || width == null || height == null || rotation == null)
        val checkFilePath = type == INPUT_IMAGE_TYPE_URI && (path == null)
        if (checkByteArray || checkFilePath) {
            result.error(ERROR_SCAN_INPUT_IMAGE_INVALID_ARGUMENTS, "Invalid arguments", null)
        }

        // Prepare InputImage
        val image: InputImage? = when (type) {
            INPUT_IMAGE_TYPE_BYTE_ARRAY -> {
                InputImage.fromByteArray(
                    bytes, width!!, height!!, rotation!!, InputImage.IMAGE_FORMAT_NV21
                )
            }
            INPUT_IMAGE_TYPE_URI -> {
                val uri = try {
                    Uri.fromFile(File(path))
                } catch (e: Exception) {
                    result.error(ERROR_SCAN_INPUT_IMAGE_PARSE_URI, "Could not parse path: $e", null)
                    null
                }

                if (uri != null) {
                    try {
                        InputImage.fromFilePath(context, uri)
                    } catch (e: IOException) {
                        result.error(
                            ERROR_SCAN_INPUT_IMAGE_FILE_NOT_FOUND,
                            "File not found: $e",
                            null
                        )
                        null
                    }
                } else {
                    null
                }
            }
            else -> {
                result.error(
                    ERROR_SCAN_INPUT_IMAGE_UNKNOWN_TYPE,
                    "Unrecognized type of InputImage",
                    null
                )
                null
            }
        }

        // Process image
        image?.let {
            scanner.process(it)
                .addOnSuccessListener { barcodes ->
                    result.success(processBarcodes(barcodes).toString())
                }
                .addOnFailureListener { error ->
                    result.error(
                        ERROR_SCAN_INPUT_IMAGE_PROCESS_FAILURE,
                        "Could not scan image: $error",
                        null
                    )
                }
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
