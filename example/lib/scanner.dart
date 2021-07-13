import 'package:flutter/material.dart';
import 'package:ml_kit_barcode_scanner_example/camera_view.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScanner extends StatefulWidget {
  @override
  _CameraScannerState createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  // ********************************* VARS ******************************** //

  late final Future<bool> _cameraPermissionFuture;

  // ****************************** LIFECYCLE ****************************** //

  @override
  void initState() {
    super.initState();

    _cameraPermissionFuture = _requestCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
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
    );
  }

  // *************************** PRIVATE METHODS *************************** //

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
