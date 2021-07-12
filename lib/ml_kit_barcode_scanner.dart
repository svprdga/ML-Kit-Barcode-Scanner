import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/native_wrapper.dart';

class InputImage {
  final Uint8List bytes;
  final Size size;
  final int rotation;

  InputImage(
      {required this.bytes,
      required this.size,
      required this.rotation});
}

class MlKitBarcodeScanner {
  // ********************************* VARS ******************************** //

  final NativeWrapper _native = NativeWrapper();

  //***************************** PUBLIC METHODS *************************** //

  Future<void> scanBytes(InputImage inputImage) async {
    final result = await _native.scanBytes(inputImage);
  }
}
