part of ml_kit_barcode_scanner;

enum InputImageFormat { NV21, YV12, YUV_420_888, YUV420, BGRA8888 }

extension InputImageFormatExtension on InputImageFormat {
  static const _NV21 = 17;
  static const _YV12 = 842094169;
  static const _YUV_420_888 = 35;
  static const _YUV420 = 875704438;
  static const _BGRA8888 = 1111970369;

  static InputImageFormat? getFromRawValue(int value) {
    switch (value) {
      case _NV21:
        return InputImageFormat.NV21;
      case _YV12:
        return InputImageFormat.YV12;
      case _YUV_420_888:
        return InputImageFormat.YUV_420_888;
      case _YUV420:
        return InputImageFormat.YUV420;
      case _BGRA8888:
        return InputImageFormat.BGRA8888;
      default:
        return null;
    }
  }

  int get value {
    switch (this) {
      case InputImageFormat.NV21:
        return _NV21;
      case InputImageFormat.YV12:
        return _YV12;
      case InputImageFormat.YUV_420_888:
        return _YUV_420_888;
      case InputImageFormat.YUV420:
        return _YUV420;
      case InputImageFormat.BGRA8888:
        return _BGRA8888;
    }
  }
}

class InputImagePlaneMetadata {
  final int bytes;
  final int? height;
  final int? width;

  InputImagePlaneMetadata({required this.bytes, this.height, this.width});
}

enum InputImageType { byteArray, uri }

class InputImage {
  final InputImageType imageType;
  final Uint8List? bytes;
  final InputImageFormat? imageFormat;
  final int? imageWidth;
  final int? imageHeight;
  final int? rotation;
  final List<InputImagePlaneMetadata>? planeMetadata;
  final String? uri;

  InputImage(
      {required this.imageType,
      this.bytes,
      this.imageFormat,
      this.imageWidth,
      this.imageHeight,
      this.rotation,
      this.planeMetadata,
      this.uri});

  factory InputImage.fromByteArray(
      {required Uint8List bytes,
      required InputImageFormat imageFormat,
      required int width,
      required int height,
      required List<InputImagePlaneMetadata> planeMetadata,
      required int rotation}) {
    return InputImage(
        imageType: InputImageType.byteArray,
        bytes: bytes,
        imageFormat: imageFormat,
        imageWidth: width,
        imageHeight: height,
        planeMetadata: planeMetadata,
        rotation: rotation);
  }

  factory InputImage.fromFilePath({required String filePath}) {
    return InputImage(imageType: InputImageType.uri, uri: filePath);
  }
}

class FileImage {
  final File file;

  FileImage({required this.file});
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
  BarcodeContactInfo({
    required String rawValue,
  }) : super(valueType: BarcodeValueType.contactInfo, rawValue: rawValue);
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
