part of ml_kit_barcode_scanner;

class InputImage {
  final Uint8List bytes;
  final Size size;
  final int rotation;

  InputImage({required this.bytes, required this.size, required this.rotation});
}

enum BarcodeValueType {
  UNKNOWN,
  CONTACT_INFO,
  EMAIL,
  ISBN,
  PHONE,
  PRODUCT,
  SMS,
  TEXT,
  URL,
  WIFI,
  LOCATION,
  CALENDAR_EVENT,
  DRIVER_LICENSE
}

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
      {required String rawValue,
      this.end,
      this.start,
      this.description,
      this.location,
      this.organizer,
      this.status,
      this.summary})
      : super(valueType: BarcodeValueType.CALENDAR_EVENT, rawValue: rawValue);
}

class BarcodeLocation extends Barcode {
  final double? latitude;
  final double? longitude;

  BarcodeLocation({required String rawValue, this.latitude, this.longitude})
      : super(valueType: BarcodeValueType.LOCATION, rawValue: rawValue);
}

class BarcodeContactInfo extends Barcode {
  final String? addresses;
  final String? emails;
  final String? name;
  final String? phones;
  final String? title;
  final String? urls;
  final String? organization;

  BarcodeContactInfo(
      {required String rawValue,
      this.addresses,
      this.emails,
      this.name,
      this.phones,
      this.title,
      this.urls,
      this.organization})
      : super(valueType: BarcodeValueType.CONTACT_INFO, rawValue: rawValue);
}

class BarcodeDriverLicense extends Barcode {
  final String? addressCity;
  final String? addressState;
  final String? addressStreet;
  final String? addressZip;
  final DateTime? birthDate;
  final String? documentType;
  final DateTime? expiryDate;
  final String? firstName;
  final String? gender;
  final DateTime? issueDate;
  final String? issuingCountry;
  final String? lastName;
  final String? middleName;
  final String? licenseNumber;

  BarcodeDriverLicense(
      {required String rawValue,
      this.addressCity,
      this.addressState,
      this.addressStreet,
      this.addressZip,
      this.birthDate,
      this.documentType,
      this.expiryDate,
      this.firstName,
      this.gender,
      this.issueDate,
      this.issuingCountry,
      this.lastName,
      this.middleName,
      this.licenseNumber})
      : super(valueType: BarcodeValueType.DRIVER_LICENSE, rawValue: rawValue);
}

enum EmailType { UNKNOWN, WORK, HOME }

class BarcodeEmail extends Barcode {
  final String? address;
  final String? body;
  final String? subject;
  final EmailType emailType;

  BarcodeEmail(
      {required String rawValue,
      this.address,
      this.body,
      this.subject,
      this.emailType = EmailType.UNKNOWN})
      : super(valueType: BarcodeValueType.EMAIL, rawValue: rawValue);
}

enum PhoneType { UNKNOWN, WORK, HOME, FAX, MOBILE }

class BarcodePhone extends Barcode {
  final String? number;
  final PhoneType phoneType;

  BarcodePhone(
      {required String rawValue,
      this.number,
      this.phoneType = PhoneType.UNKNOWN})
      : super(valueType: BarcodeValueType.PHONE, rawValue: rawValue);
}

class BarcodeSms extends Barcode {
  final String? message;
  final String? phoneNumber;

  BarcodeSms({required String rawValue, this.message, this.phoneNumber})
      : super(valueType: BarcodeValueType.SMS, rawValue: rawValue);
}

class BarcodeUrl extends Barcode {
  final String? title;
  final String? url;

  BarcodeUrl({required String rawValue, this.title, this.url})
      : super(valueType: BarcodeValueType.URL, rawValue: rawValue);
}

enum WifiEncryptionType { UNKNOWN, OPEN, WPA, WEP }

class BarcodeWifi extends Barcode {
  final String? ssid;
  final String? password;
  final WifiEncryptionType encryptionType;

  BarcodeWifi(
      {required String rawValue,
      this.ssid,
      this.password,
      this.encryptionType = WifiEncryptionType.UNKNOWN})
      : super(valueType: BarcodeValueType.WIFI, rawValue: rawValue);
}

class BarcodeIsbn extends Barcode {
  BarcodeIsbn({required String rawValue})
      : super(valueType: BarcodeValueType.ISBN, rawValue: rawValue);
}

class BarcodeProduct extends Barcode {
  BarcodeProduct({required String rawValue})
      : super(valueType: BarcodeValueType.PRODUCT, rawValue: rawValue);
}

class BarcodeText extends Barcode {
  BarcodeText({required String rawValue})
      : super(valueType: BarcodeValueType.TEXT, rawValue: rawValue);
}


