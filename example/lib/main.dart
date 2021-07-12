import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';
import 'package:ml_kit_barcode_scanner_example/camera_view.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  late final Future<bool> _cameraPermissionFuture;

  @override
  void initState() {
    super.initState();

    _cameraPermissionFuture = _requestCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: FutureBuilder<bool>(
          future: _cameraPermissionFuture,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return _getScannerLayout();
            } else if (snapshot.hasData) {
              return _getNoPermissionsLayout();
            } else {
              return _getLoadingLayout();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _requestCameraPermission() async {
    final result = await Permission.camera.request();
    return result.isGranted;
  }

  Widget _getLoadingLayout() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getNoPermissionsLayout() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Text('Camera permission denied.'),
      ),
    );
  }

  Widget _getScannerLayout() {
    return CameraView();
  }
}
