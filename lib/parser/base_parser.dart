import 'package:flutter/widgets.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';
import 'package:ml_kit_barcode_scanner/native_entities.dart';

abstract class BaseParser<T extends Barcode> {
  //***************************** PUBLIC METHODS *************************** //

  T parse(BarcodeEntity entity);

  //**************************** PROTECTED METHODS ************************* //

  @protected
  BarcodeValueType getValueType(int valueType) {
    switch (valueType) {
      case TYPE_LOCATION:
        return BarcodeValueType.LOCATION;
      default:
        return BarcodeValueType.UNKNOWN;
    }
  }
}
