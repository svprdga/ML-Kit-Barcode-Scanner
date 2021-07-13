import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';

class NativeWrapper {
  // ****************************** CONSTANTS ****************************** //

  static const _CHANNEL = 'ml_kit_barcode_scanner';

  static const _NATIVE_SCAN_INPUT_IMAGE = 'scan_input_image';
  static const ERROR_SCAN_INPUT_IMAGE_INVALID_ARGUMENTS =
      "error_${_NATIVE_SCAN_INPUT_IMAGE}_invalid_arguments";
  static const ERROR_SCAN_INPUT_IMAGE_PARSE_URI =
      "error_${_NATIVE_SCAN_INPUT_IMAGE}_parse_uri";
  static const ERROR_SCAN_INPUT_IMAGE_FILE_NOT_FOUND =
      "error_${_NATIVE_SCAN_INPUT_IMAGE}_file_not_found";
  static const ERROR_SCAN_INPUT_IMAGE_UNKNOWN_TYPE =
      "error_${_NATIVE_SCAN_INPUT_IMAGE}_unknown_type";
  static const ERROR_SCAN_INPUT_IMAGE_PROCESS_FAILURE =
      "error_${_NATIVE_SCAN_INPUT_IMAGE}_process_failure";

  // ********************************* VARS ******************************** //

  final MethodChannel _platform = MethodChannel(_CHANNEL);

  //***************************** PUBLIC METHODS *************************** //

  Future<dynamic> scan(InputImage inputImage) async {
    final result = await _platform.invokeMethod(_NATIVE_SCAN_INPUT_IMAGE, [
      inputImage.imageType.index,
      inputImage.bytes,
      inputImage.imageWidth,
      inputImage.imageHeight,
      inputImage.rotation,
      inputImage.uri,
    ]);

    return jsonDecode(result);
  }
}
