part of ml_kit_barcode_scanner;

class BarcodeParserException implements Exception {
  final String message;

  BarcodeParserException({required this.message});

  @override
  String toString() => message;
}

class BarcodeParser {
  //***************************** PUBLIC METHODS *************************** //

  Barcode parse(BarcodeEntity entity) {
    switch (entity.valueType) {
      case TYPE_CONTACT_INFO:
        return _parseContactInfo(entity);
      case TYPE_EMAIL:
        return _parseEmail(entity);
      case TYPE_ISBN:
        return _parseIsbn(entity);
      case TYPE_PHONE:
        return _parsePhone(entity);
      case TYPE_PRODUCT:
        return _parseProduct(entity);
      case TYPE_SMS:
        return _parseSms(entity);
      case TYPE_TEXT:
        return _parseText(entity);
      case TYPE_URL:
        return _parseUrl(entity);
      case TYPE_WIFI:
        return _parseWifi(entity);
      case TYPE_LOCATION:
        return _parseLocation(entity);
      case TYPE_CALENDAR_EVENT:
        return _parseCalendar(entity);
      case TYPE_DRIVER_LICENSE:
        return _parseDriverLicense(entity);
      default:
        throw BarcodeParserException(
            message: 'Unknown barcode entity provided with value type ${entity
                .valueType}.');
    }
  }

  // *************************** PRIVATE METHODS *************************** //

  BarcodeCalendarEvent _parseCalendar(BarcodeEntity entity) {
    return BarcodeCalendarEvent(
        rawValue: entity.rawValue,
        start: entity.calendarStart != null
            ? DateTime.parse(entity.calendarStart!)
            : null,
        end: entity.calendarEnd != null
            ? DateTime.parse(entity.calendarEnd!)
            : null,
        description: entity.calendarDescription,
        location: entity.calendarLocation,
        organizer: entity.calendarOrganizer,
        status: entity.calendarStatus,
        summary: entity.calendarSummary);
  }

  BarcodeLocation _parseLocation(BarcodeEntity entity) {
    return BarcodeLocation(
        rawValue: entity.rawValue,
        latitude: entity.locationLatitude,
        longitude: entity.locationLongitude);
  }

  BarcodeContactInfo _parseContactInfo(BarcodeEntity entity) {
    return BarcodeContactInfo(
        rawValue: entity.rawValue,
        addresses: entity.contactInfoAddresses,
        emails: entity.contactInfoEmails,
        name: entity.contactInfoName,
        phones: entity.contactInfoPhones,
        title: entity.contactInfoTitle,
        urls: entity.contactInfoUrls,
        organization: entity.contactInfoOrganization);
  }

  BarcodeDriverLicense _parseDriverLicense(BarcodeEntity entity) {
    return BarcodeDriverLicense(
        rawValue: entity.rawValue,
        addressCity: entity.driverLicenseAddressCity,
        addressState: entity.driverLicenseAddressState,
        addressStreet: entity.driverLicenseAddressStreet,
        addressZip: entity.driverLicenseAddressZip,
        birthDate: entity.driverLicenseBirthDate != null
            ? DateTime.parse(entity.driverLicenseBirthDate!)
            : null,
        documentType: entity.driverLicenseDocumentType,
        expiryDate: entity.driverLicenseExpiryDate != null
            ? DateTime.parse(entity.driverLicenseExpiryDate!)
            : null,
        firstName: entity.driverLicenseFirstName,
        gender: entity.driverLicenseGender,
        issueDate: entity.driverLicenseIssueDate != null
            ? DateTime.parse(entity.driverLicenseIssueDate!)
            : null,
        issuingCountry: entity.driverLicenseIssuingCountry,
        lastName: entity.driverLicenseLastName,
        middleName: entity.driverLicenseMiddleName,
        licenseNumber: entity.driverLicenseLicenseNumber);
  }

  BarcodeEmail _parseEmail(BarcodeEntity entity) {
    EmailType type = EmailType.unknown;
    if (entity.emailType != null) {
      switch (entity.emailType) {
        case EMAIL_TYPE_HOME:
          type = EmailType.home;
          break;
        case EMAIL_TYPE_WORK:
          type = EmailType.work;
          break;
        default:
          type = EmailType.unknown;
      }
    }

    return BarcodeEmail(
        rawValue: entity.rawValue,
        address: entity.emailAddress,
        body: entity.emailBody,
        subject: entity.emailSubject,
        emailType: type);
  }

  BarcodePhone _parsePhone(BarcodeEntity entity) {
    PhoneType type = PhoneType.unknown;
    if (entity.phoneType != null) {
      switch (entity.phoneType) {
        case PHONE_TYPE_FAX:
          type = PhoneType.fax;
          break;
        case PHONE_TYPE_HOME:
          type = PhoneType.home;
          break;
        case PHONE_TYPE_MOBILE:
          type = PhoneType.mobile;
          break;
        case PHONE_TYPE_WORK:
          type = PhoneType.work;
          break;
        default:
          type = PhoneType.unknown;
      }
    }

    return BarcodePhone(
        rawValue: entity.rawValue, number: entity.phoneNumber, phoneType: type);
  }

  BarcodeSms _parseSms(BarcodeEntity entity) {
    return BarcodeSms(
        rawValue: entity.rawValue,
        message: entity.smsMessage,
        phoneNumber: entity.smsPhoneNumber);
  }

  BarcodeUrl _parseUrl(BarcodeEntity entity) {
    return BarcodeUrl(
      rawValue: entity.rawValue,
      url: entity.urlUrl,
    );
  }

  BarcodeWifi _parseWifi(BarcodeEntity entity) {
    WifiEncryptionType type = WifiEncryptionType.unknown;
    if (entity.wifiEncryptionType != null) {
      switch (entity.wifiEncryptionType) {
        case WIFI_ENCRYPTION_TYPE_OPEN:
          type = WifiEncryptionType.open;
          break;
        case WIFI_ENCRYPTION_TYPE_WPA:
          type = WifiEncryptionType.wpa;
          break;
        case WIFI_ENCRYPTION_TYPE_WEP:
          type = WifiEncryptionType.wep;
          break;
        default:
          type = WifiEncryptionType.unknown;
      }
    }

    return BarcodeWifi(
        rawValue: entity.rawValue,
        ssid: entity.wifiSsid,
        password: entity.wifiPassword,
        encryptionType: type);
  }

  BarcodeIsbn _parseIsbn(BarcodeEntity entity) {
    return BarcodeIsbn(rawValue: entity.rawValue);
  }

  BarcodeProduct _parseProduct(BarcodeEntity entity) {
    return BarcodeProduct(rawValue: entity.rawValue);
  }

  BarcodeText _parseText(BarcodeEntity entity) {
    return BarcodeText(rawValue: entity.rawValue);
  }
}
