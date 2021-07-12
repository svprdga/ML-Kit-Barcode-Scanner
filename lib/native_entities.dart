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

const EMAIL_TYPE_UNKNOWN = 0;
const EMAIL_TYPE_WORK = 1;
const EMAIL_TYPE_HOME = 2;

const PHONE_TYPE_UNKNOWN = 0;
const PHONE_TYPE_WORK = 1;
const PHONE_TYPE_HOME = 2;
const PHONE_TYPE_FAX = 3;
const PHONE_TYPE_MOBILE = 4;

const WIFI_ENCRYPTION_TYPE_OPEN = 1;
const WIFI_ENCRYPTION_TYPE_WPA = 2;
const WIFI_ENCRYPTION_TYPE_WEP = 3;

class BarcodeEntity {
  final String rawValue;
  final int valueType;

  // Contact info
  final String? contactInfoAddresses;
  final String? contactInfoEmails;
  final String? contactInfoName;
  final String? contactInfoPhones;
  final String? contactInfoTitle;
  final String? contactInfoUrls;
  final String? contactInfoOrganization;

  // Driver license
  final String? driverLicenseAddressCity;
  final String? driverLicenseAddressState;
  final String? driverLicenseAddressStreet;
  final String? driverLicenseAddressZip;
  final String? driverLicenseBirthDate;
  final String? driverLicenseDocumentType;
  final String? driverLicenseExpiryDate;
  final String? driverLicenseFirstName;
  final String? driverLicenseGender;
  final String? driverLicenseIssueDate;
  final String? driverLicenseIssuingCountry;
  final String? driverLicenseLastName;
  final String? driverLicenseMiddleName;
  final String? driverLicenseLicenseNumber;

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

  // Email
  final String? emailAddress;
  final String? emailBody;
  final String? emailSubject;
  final int? emailType;

  // Phone
  final String? phoneNumber;
  final int? phoneType;

  // Sms
  final String? smsMessage;
  final String? smsPhoneNumber;

  // Url
  final String? urlTitle;
  final String? urlUrl;

  // Wifi
  final String? wifiSsid;
  final int? wifiEncryptionType;
  final String? wifiPassword;

  BarcodeEntity(
      {required this.rawValue,
      required this.valueType,
      this.contactInfoAddresses,
      this.contactInfoEmails,
      this.contactInfoName,
      this.contactInfoOrganization,
      this.contactInfoPhones,
      this.contactInfoTitle,
      this.contactInfoUrls,
      this.driverLicenseAddressCity,
      this.driverLicenseAddressState,
      this.driverLicenseAddressStreet,
      this.driverLicenseAddressZip,
      this.driverLicenseBirthDate,
      this.driverLicenseDocumentType,
      this.driverLicenseExpiryDate,
      this.driverLicenseFirstName,
      this.driverLicenseGender,
      this.driverLicenseIssueDate,
      this.driverLicenseIssuingCountry,
      this.driverLicenseLastName,
      this.driverLicenseMiddleName,
      this.driverLicenseLicenseNumber,
      this.calendarDescription,
      this.calendarEnd,
      this.calendarLocation,
      this.calendarOrganizer,
      this.calendarStart,
      this.calendarStatus,
      this.calendarSummary,
      this.locationLatitude,
      this.locationLongitude,
      this.emailAddress,
      this.emailBody,
      this.emailSubject,
      this.emailType,
      this.phoneNumber,
      this.phoneType,
      this.smsMessage,
      this.smsPhoneNumber,
      this.urlTitle,
      this.urlUrl,
      this.wifiSsid,
      this.wifiEncryptionType,
      this.wifiPassword});

  factory BarcodeEntity.fromJson(Map<String, dynamic> json) {
    return BarcodeEntity(
      rawValue: json['rawValue'],
      valueType: json['valueType'],

      // Contact info
      contactInfoAddresses: json['contactInfoAddresses'],
      contactInfoEmails: json['contactInfoEmails'],
      contactInfoName: json['contactInfoName'],
      contactInfoPhones: json['contactInfoPhones'],
      contactInfoTitle: json['contactInfoTitle'],
      contactInfoUrls: json['contactInfoUrls'],
      contactInfoOrganization: json['contactInfoOrganization'],

      // Driver license
      driverLicenseAddressCity: json['driverLicenseAddressCity'],
      driverLicenseAddressState: json['driverLicenseAddressState'],
      driverLicenseAddressStreet: json['driverLicenseAddressStreet'],
      driverLicenseAddressZip: json['driverLicenseAddressZip'],
      driverLicenseBirthDate: json['driverLicenseBirthDate'],
      driverLicenseDocumentType: json['driverLicenseDocumentType'],
      driverLicenseExpiryDate: json['driverLicenseExpiryDate'],
      driverLicenseFirstName: json['driverLicenseFirstName'],
      driverLicenseGender: json['driverLicenseGender'],
      driverLicenseIssueDate: json['driverLicenseIssueDate'],
      driverLicenseIssuingCountry: json['driverLicenseIssuingCountry'],
      driverLicenseLastName: json['driverLicenseLastName'],
      driverLicenseMiddleName: json['driverLicenseMiddleName'],
      driverLicenseLicenseNumber: json['driverLicenseLicenseNumber'],

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
      locationLongitude: json['locationLongitude'],

      // Email
      emailAddress: json['emailAddress'],
      emailBody: json['emailBody'],
      emailSubject: json['emailSubject'],
      emailType: json['emailType'],

      // Phone
      phoneNumber: json['phoneNumber'],
      phoneType: json['phoneType'],

      // Sms
      smsMessage: json['smsMessage'],
      smsPhoneNumber: json['smsPhoneNumber'],

      // Url
      urlTitle: json['urlTitle'],
      urlUrl: json['urlUrl'],

      // Wifi
      wifiSsid: json['wifiSsid'],
      wifiEncryptionType: json['wifiEncryptionType'],
      wifiPassword: json['wifiPassword'],
    );
  }
}
