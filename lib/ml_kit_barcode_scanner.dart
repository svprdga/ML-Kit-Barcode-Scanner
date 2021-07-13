library ml_kit_barcode_scanner;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/native_entities.dart';
import 'package:ml_kit_barcode_scanner/native_wrapper.dart';

part './models.dart';

part './parsers.dart';

part './exceptions.dart';

class MlKitBarcodeScanner {
  // ********************************* VARS ******************************** //

  final NativeWrapper _native = NativeWrapper();
  final BarcodeParser _parser = BarcodeParser();

  //***************************** PUBLIC METHODS *************************** //

  Future<List<Barcode>> scan(InputImage inputImage) async {
    try {
      final result = await _native.scan(inputImage);
      final scanResult = ScanResultEntity.fromJson(result);

      List<Barcode> barcodes = [];
      scanResult.barcodes.forEach((entity) {
        try {
          barcodes.add(_parser.parse(entity));
        } catch (e) {
          print('Could not parse entity: $entity');
        }
      });

      return barcodes;
    } on PlatformException catch (e) {
      if (e.code == NativeWrapper.ERROR_SCAN_INPUT_IMAGE_PARSE_URI) {
        throw InvalidFilePathException(
            message: e.message ?? 'Could not parse the provided file path.');
      } else if (e.code ==
          NativeWrapper.ERROR_SCAN_INPUT_IMAGE_FILE_NOT_FOUND) {
        throw FileNotFoundException(
            message:
                e.message ?? 'Could not found a file in the provided path.');
      } else if (e.code ==
          NativeWrapper.ERROR_SCAN_INPUT_IMAGE_PROCESS_FAILURE) {
        throw ProcessImageFailureException(
            message: e.message ?? 'Error when processing the provided image.');
      } else {
        throw e;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
