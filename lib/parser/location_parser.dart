part of ml_kit_barcode_scanner;

class LocationParser extends BaseParser {
  //***************************** PUBLIC METHODS *************************** //

  @override
  BarcodeLocation parse(BarcodeEntity entity) {
    return BarcodeLocation(
        valueType: getValueType(entity.valueType),
        rawValue: entity.rawValue,
        latitude: entity.locationLatitude,
        longitude: entity.locationLongitude);
  }
}
