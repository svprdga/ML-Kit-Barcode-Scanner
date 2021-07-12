class ScanResult {
  final List<BarcodeEntity> barcodes;

  ScanResult({required this.barcodes});

  factory ScanResult.fromJson(dynamic json) {
    final barcodes = List<Map<String, dynamic>>.from(json);

    List<BarcodeEntity> entities = [];
    barcodes.forEach((entity) {
      entities.add(BarcodeEntity.fromJson(entity));
    });

    return ScanResult(barcodes: entities);
  }
}

const TYPE_UNKNOWN = 0;
const TYPE_CONTACT_INFO = 1;
const TYPE_EMAIL = 2;
const TYPE_ISBN = 3;
const TYPE_PHONE = 4;
const TYPE_PRODUCT = 5;
const TYPE_SMS = 6;
const TYPE_TEXT = 7;
const TYPE_URL = 8;
const TYPE_WIFI = 9;
const TYPE_LOCATION = 10;
const TYPE_CALENDAR_EVENT = 11;
const TYPE_DRIVER_LICENSE = 12;

class BarcodeEntity {
  final String rawValue;
  final int valueType;

  // Calendar
  final String? calendarDescription;
  final String? calendarEnd;
  final String? calendarLocation;
  final String? calendarOrganizer;
  final String? calendarStart;
  final String? calendarStatus;
  final String? calendarSummary;

  // Location
  final double? locationLatitude;
  final double? locationLongitude;

  BarcodeEntity(
      {required this.rawValue,
      required this.valueType,
      this.calendarDescription,
      this.calendarEnd,
      this.calendarLocation,
      this.calendarOrganizer,
      this.calendarStart,
      this.calendarStatus,
      this.calendarSummary,
      this.locationLatitude,
      this.locationLongitude});

  factory BarcodeEntity.fromJson(Map<String, dynamic> json) {
    return BarcodeEntity(
        rawValue: json['rawValue'],
        valueType: json['valueType'],

        // Calendar
        calendarDescription: json['calendarDescription'],
        calendarEnd: json['calendarEnd'],
        calendarLocation: json['calendarLocation'],
        calendarOrganizer: json['calendarOrganizer'],
        calendarStart: json['calendarStart'],
        calendarStatus: json['calendarStatus'],
        calendarSummary: json['calendarSummary'],

        // Location
        locationLatitude: json['locationLatitude'],
        locationLongitude: json['locationLongitude']);
  }
}
