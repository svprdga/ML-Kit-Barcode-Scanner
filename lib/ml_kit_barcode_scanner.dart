
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/native_wrapper.dart';

class MlKitBarcodeScanner {

  // ********************************* VARS ******************************** //

  final NativeWrapper _native = NativeWrapper();

  //***************************** PUBLIC METHODS *************************** //

  Future<void> scanBytes(Uint8List bytes) async {
    await _native.scanBytes(bytes);
  }
}
