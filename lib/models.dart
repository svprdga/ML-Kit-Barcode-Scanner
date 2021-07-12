part of ml_kit_barcode_scanner;

class InputImage {
  final Uint8List bytes;
  final Size size;
  final int rotation;

  InputImage({required this.bytes, required this.size, required this.rotation});
}

enum BarcodeValueType { CALENDAR_EVENT, LOCATION, UNKNOWN }

abstract class Barcode {
  final BarcodeValueType valueType;
  final String rawValue;

  Barcode({required this.valueType, required this.rawValue});
}

class BarcodeCalendarEvent extends Barcode {
  final DateTime? start;
  final DateTime? end;
  final String? description;
  final String? location;
  final String? organizer;
  final String? status;
  final String? summary;

  BarcodeCalendarEvent(
      {required BarcodeValueType valueType,
      required String rawValue,
      this.end,
      this.start,
      this.description,
      this.location,
      this.organizer,
      this.status,
      this.summary})
      : super(valueType: valueType, rawValue: rawValue);
}

class BarcodeLocation extends Barcode {
  final double? latitude;
  final double? longitude;

  BarcodeLocation(
      {required BarcodeValueType valueType,
      required String rawValue,
      this.latitude,
      this.longitude})
      : super(valueType: valueType, rawValue: rawValue);
}
