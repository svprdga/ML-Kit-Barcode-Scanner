library ml_kit_barcode_scanner;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ml_kit_barcode_scanner/native_entities.dart';
import 'package:ml_kit_barcode_scanner/native_wrapper.dart';

part './models.dart';

part './parsers.dart';

class MlKitBarcodeScanner {
  // ********************************* VARS ******************************** //

  final NativeWrapper _native = NativeWrapper();
  final BarcodeParser _parser = BarcodeParser();

  //***************************** PUBLIC METHODS *************************** //

  Future<List<Barcode>> scan(InputImage inputImage) async {
    final result = await _native.scan(inputImage);
    final scanResult = ScanResult.fromJson(result);

    List<Barcode> barcodes = [];
    scanResult.barcodes.forEach((entity) {
      try {
        barcodes.add(_parser.parse(entity));
      } catch (e) {
        print('Could not parse entity: $entity');
      }
    });

    return barcodes;
  }
}
