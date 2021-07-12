import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';

class CameraView extends StatefulWidget {
  CameraView({Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView>
    with WidgetsBindingObserver {

  // ********************************* VARS ******************************** //

  CameraController? _cameraController;
  bool _isDetecting = false;
  final MlKitBarcodeScanner _scanner = MlKitBarcodeScanner();

  // ****************************** LIFECYCLE ****************************** //

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addObserver(this);

    // _static = Provider.of<StaticWrapper>(context, listen: false);
    // _scannerUtils = Provider.of<ScannerUtils>(context, listen: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _stopCamera();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Camera lifecycle.
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: availableCameras(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CameraDescription>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          _initCameraController(snapshot.data!);

          return Center(
            child: CameraPreview(_cameraController!),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  // *************************** PRIVATE METHODS *************************** //

  _startCamera() {
    _cameraSelected(_cameraController!.description);
    _isDetecting = false;
  }

  _stopCamera() {
    if (_cameraController != null) {
      // _barcodeScanner?.close();
      _cameraController?.dispose();
    }
  }

  _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  _cameraSelected(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});

    // _barcodeScanner = GoogleMlKit.vision.barcodeScanner();
    _cameraController?.startImageStream((CameraImage image) {
      _processFrame(camera, image);
    });
  }

  _processFrame(CameraDescription camera, CameraImage image) async {
    if (_isDetecting) {
      return;
    } else {
      _isDetecting = true;
    }

    try {

        final WriteBuffer allBytes = WriteBuffer();
        for (Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();
        _scanner.scanBytes(bytes);

      // final inputImage = _scannerUtils.createInputImage(camera, image);
      // final List<Barcode> barcodes =
      //     await _barcodeScanner!.processImage(inputImage);
      //
      // _processBarcodes(barcodes);
      _isDetecting = false; // TODO remove
    } catch (e) {
      print('Error processing camera frame: $e');
      _isDetecting = false;
    }
  }

  // _processBarcodes(List<Barcode> barcodes) async {
  //   final barcode = await widget.mainBloc.processBarcodes(barcodes);
  //
  //   if (barcode != null) {
  //     _stopCamera();
  //
  //     if (isMaterial(context)) {
  //       await Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) =>
  //                   CodeScreen(barcode: barcode)));
  //     } else {
  //       await Navigator.of(context, rootNavigator: true).push(
  //           CupertinoPageRoute(
  //               maintainState: false,
  //               builder: (BuildContext context) =>
  //                   CodeScreen(barcode: barcode)));
  //     }
  //
  //     _startCamera();
  //   } else {
  //     _isDetecting = false;
  //   }
  // }
}
