
import 'dart:async';

import 'package:flutter/services.dart';

class MlKitBarcodeScanner {
  static const MethodChannel _channel =
      const MethodChannel('ml_kit_barcode_scanner');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
