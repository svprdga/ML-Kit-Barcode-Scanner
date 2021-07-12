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
      case BarcodeValueType.LOCATION:
        title = 'Location';
        body = _getLocationBody();
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

  String _getLocationBody() {
    final barcodeLocation = barcode as BarcodeLocation;

    return '''This code contains a location:
    
        - Latitude: ${barcodeLocation.latitude}
        - Longitude: ${barcodeLocation.longitude}
    ''';
  }

  String _getUnknownBody() {
    return '''This code has an unknown format:
    
        - Raw value: ${barcode.rawValue}
    ''';
  }
}
