import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';

class NativeWrapper {
  // ****************************** CONSTANTS ****************************** //

  static const _CHANNEL = 'ml_kit_barcode_scanner';

  static const _NATIVE_SCAN_INPUT_IMAGE = 'scan_input_image';

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
