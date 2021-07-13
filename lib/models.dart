part of ml_kit_barcode_scanner;

class InputImage {
  final Uint8List bytes;
  final Size size;
  final int rotation;

  InputImage({required this.bytes, required this.size, required this.rotation});
}

enum BarcodeValueType {
  unknown,
  contactInfo,
  email,
  isbn,
  phone,
  product,
  sms,
  text,
  url,
  wifi,
  location,
  calendarEvent,
  driverLicense
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
      : super(valueType: BarcodeValueType.calendarEvent, rawValue: rawValue);
}

class BarcodeLocation extends Barcode {
  final double? latitude;
  final double? longitude;

  BarcodeLocation({required String rawValue, this.latitude, this.longitude})
      : super(valueType: BarcodeValueType.location, rawValue: rawValue);
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
      : super(valueType: BarcodeValueType.contactInfo, rawValue: rawValue);
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
      : super(valueType: BarcodeValueType.driverLicense, rawValue: rawValue);
}

enum EmailType { unknown, work, home }

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
      this.emailType = EmailType.unknown})
      : super(valueType: BarcodeValueType.email, rawValue: rawValue);
}

enum PhoneType { unknown, work, home, fax, mobile }

class BarcodePhone extends Barcode {
  final String? number;
  final PhoneType phoneType;

  BarcodePhone(
      {required String rawValue,
      this.number,
      this.phoneType = PhoneType.unknown})
      : super(valueType: BarcodeValueType.phone, rawValue: rawValue);
}

class BarcodeSms extends Barcode {
  final String? message;
  final String? phoneNumber;

  BarcodeSms({required String rawValue, this.message, this.phoneNumber})
      : super(valueType: BarcodeValueType.sms, rawValue: rawValue);
}

class BarcodeUrl extends Barcode {
  final String? title;
  final String? url;

  BarcodeUrl({required String rawValue, this.title, this.url})
      : super(valueType: BarcodeValueType.url, rawValue: rawValue);
}

enum WifiEncryptionType { unknown, open, wpa, wep }

class BarcodeWifi extends Barcode {
  final String? ssid;
  final String? password;
  final WifiEncryptionType encryptionType;

  BarcodeWifi(
      {required String rawValue,
      this.ssid,
      this.password,
      this.encryptionType = WifiEncryptionType.unknown})
      : super(valueType: BarcodeValueType.wifi, rawValue: rawValue);
}

class BarcodeIsbn extends Barcode {
  BarcodeIsbn({required String rawValue})
      : super(valueType: BarcodeValueType.isbn, rawValue: rawValue);
}

class BarcodeProduct extends Barcode {
  BarcodeProduct({required String rawValue})
      : super(valueType: BarcodeValueType.product, rawValue: rawValue);
}

class BarcodeText extends Barcode {
  BarcodeText({required String rawValue})
      : super(valueType: BarcodeValueType.text, rawValue: rawValue);
}


