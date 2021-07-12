import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';
import 'package:ml_kit_barcode_scanner/native_entities.dart';

abstract class BaseParser {
  //***************************** PUBLIC METHODS *************************** //

  Barcode parse(BarcodeEntity entity);
}
