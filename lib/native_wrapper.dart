import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';

class NativeWrapper {
  // ****************************** CONSTANTS ****************************** //

  static const _CHANNEL = 'ml_kit_barcode_scanner';

  static const _NATIVE_SCAN_BYTE_ARRAY = 'scan_byte_array';

  // ********************************* VARS ******************************** //

  final MethodChannel _platform = MethodChannel(_CHANNEL);

  //***************************** PUBLIC METHODS *************************** //

  Future<dynamic> scanBytes(InputImage inputImage) async {
    final result = await _platform.invokeMethod(_NATIVE_SCAN_BYTE_ARRAY, [
      inputImage.bytes,
      inputImage.size.width,
      inputImage.size.height,
      inputImage.rotation
    ]);

    return jsonDecode(result);
  }
}
