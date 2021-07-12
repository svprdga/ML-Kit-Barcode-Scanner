library ml_kit_barcode_scanner;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ml_kit_barcode_scanner/native_entities.dart';
import 'package:ml_kit_barcode_scanner/native_wrapper.dart';
import 'package:ml_kit_barcode_scanner/parser/base_parser.dart';

part './models.dart';

part './parser/location_parser.dart';

part './parser/calendar_parser.dart';

class MlKitBarcodeScanner {
  // ********************************* VARS ******************************** //

  final NativeWrapper _native = NativeWrapper();
  final locationParser = LocationParser();
  final calendarParser = CalendarParser();

  //***************************** PUBLIC METHODS *************************** //

  Future<List<Barcode>> scanBytes(InputImage inputImage) async {
    final result = await _native.scanBytes(inputImage);
    final scanResult = ScanResult.fromJson(result);

    List<Barcode> barcodes = [];
    scanResult.barcodes.forEach((entity) {
      try {
        switch (entity.valueType) {
          case TYPE_CONTACT_INFO:
            break;
          case TYPE_EMAIL:
            break;
          case TYPE_ISBN:
            break;
          case TYPE_PHONE:
            break;
          case TYPE_PRODUCT:
            break;
          case TYPE_SMS:
            break;
          case TYPE_TEXT:
            break;
          case TYPE_URL:
            break;
          case TYPE_WIFI:
            break;
          case TYPE_LOCATION:
            barcodes.add(locationParser.parse(entity));
            break;
          case TYPE_CALENDAR_EVENT:
            barcodes.add(calendarParser.parse(entity));
            break;
          case TYPE_DRIVER_LICENSE:
            break;
          default:
        }
      } catch (e) {
        print('Could not parse entity: $entity');
      }
    });

    return barcodes;
  }
}
