import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';

class ScannerUtils {
  //***************************** PUBLIC METHODS *************************** //

  InputImage createInputImage(
      CameraDescription camera, CameraImage cameraImage) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

    // final InputImageRotation imageRotation =
    //     InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
    //         InputImageRotation.Rotation_0deg;
    final rotation = camera.sensorOrientation;

    // final InputImageFormat inputImageFormat =
    //     InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
    //         InputImageFormat.NV21;

    switch(cameraImage.format.group) {
      case ImageFormatGroup.yuv420:
        break;
      case ImageFormatGroup.bgra8888:
        break;
      case ImageFormatGroup.jpeg:
        break;
      default:
    }

    // final planeData = cameraImage.planes.map(
    //   (Plane plane) {
    //     return InputImagePlaneMetadata(
    //       bytesPerRow: plane.bytesPerRow,
    //       height: plane.height,
    //       width: plane.width,
    //     );
    //   },
    // ).toList();
    //
    // final inputImageData = InputImageData(
    //   size: imageSize,
    //   imageRotation: imageRotation,
    //   inputImageFormat: inputImageFormat,
    //   planeData: planeData,
    // );
    //
    // return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    return InputImage(
        bytes: bytes,
        size: imageSize,
        rotation: rotation);
  }
}
