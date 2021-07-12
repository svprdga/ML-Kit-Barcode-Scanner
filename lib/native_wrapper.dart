import 'dart:typed_data';

import 'package:flutter/services.dart';

class NativeWrapper {
  // ****************************** CONSTANTS ****************************** //

  static const _CHANNEL = 'ml_kit_barcode_scanner';

  static const _NATIVE_SCAN_BYTE_ARRAY = 'scan_byte_array';

  // ********************************* VARS ******************************** //

  final MethodChannel _platform = MethodChannel(_CHANNEL);

  //***************************** PUBLIC METHODS *************************** //

  Future<void> scanBytes(Uint8List bytes) async {
    await _platform.invokeMethod(_NATIVE_SCAN_BYTE_ARRAY, bytes);
  }
}