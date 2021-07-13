import 'package:flutter/material.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';

class ResultScreen extends StatelessWidget {
  // ********************************* VARS ******************************** //

  final Barcode barcode;

  // ***************************** CONSTRUCTORS **************************** //

  ResultScreen({required this.barcode});

  // ****************************** LIFECYCLE ****************************** //

  @override
  Widget build(BuildContext context) {
    String title;
    String body;
    switch (barcode.valueType) {
      case BarcodeValueType.contactInfo:
        title = 'Contact data';
        body = _getContactInfoBody();
        break;
      case BarcodeValueType.email:
        title = 'Email';
        body = _getEmailBody();
        break;
      case BarcodeValueType.isbn:
        title = 'ISBN code';
        body = _getIsbnBody();
        break;
      case BarcodeValueType.phone:
        title = 'Phone';
        body = _getPhoneBody();
        break;
      case BarcodeValueType.product:
        title = 'Product';
        body = _getProductBody();
        break;
      case BarcodeValueType.sms:
        title = 'SMS';
        body = _getSmsBody();
        break;
      case BarcodeValueType.text:
        title = 'Plain text';
        body = _getTextBody();
        break;
      case BarcodeValueType.url:
        title = 'Web address';
        body = _getUrlBody();
        break;
      case BarcodeValueType.wifi:
        title = 'WiFi';
        body = _getWifiBody();
        break;
      case BarcodeValueType.location:
        title = 'Location';
        body = _getLocationBody();
        break;
      case BarcodeValueType.calendarEvent:
        title = 'Calendar event';
        body = _getCalendarBody();
        break;
      case BarcodeValueType.driverLicense:
        title = 'Driver license';
        body = _getDriverLicenseBody();
        break;
      default:
        title = 'Unknown';
        body = _getUnknownBody();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding:
            EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom: 30.0),
        child: Text(body),
      ),
    );
  }

  // *************************** PRIVATE METHODS *************************** //

  String _getUnknownBody() {
    return '''This code has an unknown format:
    
        - Raw value: ${barcode.rawValue}
    ''';
  }

  String _getLocationBody() {
    final barcodeLocation = barcode as BarcodeLocation;

    return '''This code contains a location:
    
        - Latitude: ${barcodeLocation.latitude}
        - Longitude: ${barcodeLocation.longitude}
    ''';
  }

  String _getCalendarBody() {
    final barcodeCalendar = barcode as BarcodeCalendarEvent;

    return '''This code contains a calendar event:
    
        - Start: ${barcodeCalendar.start != null ? barcodeCalendar.start!.toIso8601String() : '-'}
        - End: ${barcodeCalendar.end != null ? barcodeCalendar.end!.toIso8601String() : '-'}
        - Location: ${barcodeCalendar.location}
        - Summary: ${barcodeCalendar.summary}
        - Status: ${barcodeCalendar.status}
        - Organizer: ${barcodeCalendar.organizer} 
    ''';
  }

  String _getContactInfoBody() {
    final barcodeContactInfo = barcode as BarcodeContactInfo;

    return '''This code contains contact information:
    
        - Raw value: ${barcodeContactInfo.rawValue}
    ''';
  }

  String _getDriverLicenseBody() {
    final barcodeDriverLicense = barcode as BarcodeDriverLicense;

    return '''This code contains a driver license:
    
        - City: ${barcodeDriverLicense.addressCity}
        - State: ${barcodeDriverLicense.addressState}
        - Street: ${barcodeDriverLicense.addressStreet}
        - Zip: ${barcodeDriverLicense.addressZip}
        - BirthDate: ${barcodeDriverLicense.birthDate != null ? barcodeDriverLicense.birthDate!.toIso8601String() : '-'}
        - Document type: ${barcodeDriverLicense.documentType}
        - Expiry date: ${barcodeDriverLicense.expiryDate != null ? barcodeDriverLicense.expiryDate!.toIso8601String() : '-'}
        - First name: ${barcodeDriverLicense.firstName}
        - Gender: ${barcodeDriverLicense.gender}
        - Issue date: ${barcodeDriverLicense.issueDate != null ? barcodeDriverLicense.issueDate!.toIso8601String() : '-'}
        - Issuing country: ${barcodeDriverLicense.issuingCountry}
        - Last name: ${barcodeDriverLicense.lastName}
        - Middle name: ${barcodeDriverLicense.middleName}
        - License number: ${barcodeDriverLicense.licenseNumber}
    ''';
  }

  String _getEmailBody() {
    final barcodeEmail = barcode as BarcodeEmail;

    return '''This code contains an email:
    
        - Address: ${barcodeEmail.address}
        - Body: ${barcodeEmail.body}
        - Subject: ${barcodeEmail.subject}
        - Type: ${barcodeEmail.emailType.toString()}
    ''';
  }

  String _getPhoneBody() {
    final barcodePhone = barcode as BarcodePhone;

    return '''This code contains a phone:
    
        - Number: ${barcodePhone.number}
        - Type: ${barcodePhone.phoneType.toString()}
    ''';
  }

  String _getSmsBody() {
    final barcodeSms = barcode as BarcodeSms;

    return '''This code contains an SMS:
    
        - Message: ${barcodeSms.message}
        - Phone number: ${barcodeSms.phoneNumber}
    ''';
  }

  String _getUrlBody() {
    final barcodeUrl = barcode as BarcodeUrl;

    return '''This code contains an URL:
    
        - Title: ${barcodeUrl.title}
        - Url: ${barcodeUrl.url}
    ''';
  }

  String _getWifiBody() {
    final barcodeWifi = barcode as BarcodeWifi;

    return '''This code contains WiFi data:
    
        - SSID: ${barcodeWifi.ssid}
        - Password: ${barcodeWifi.password}
        - Encryption type: ${barcodeWifi.encryptionType}
    ''';
  }

  String _getIsbnBody() {
    final barcodeIsbn = barcode as BarcodeIsbn;

    return '''This code contains a ISBN code:
    
        - Raw value: ${barcodeIsbn.rawValue}
    ''';
  }

  String _getProductBody() {
    final barcodeProduct = barcode as BarcodeProduct;

    return '''This code contains a product code:
    
        - Raw value: ${barcodeProduct.rawValue}
    ''';
  }

  String _getTextBody() {
    final barcodeText = barcode as BarcodeText;

    return '''This code contains plain text:
    
        - Raw value: ${barcodeText.rawValue}
    ''';
  }
}
