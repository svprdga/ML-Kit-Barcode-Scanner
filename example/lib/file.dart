import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ml_kit_barcode_scanner/ml_kit_barcode_scanner.dart';
import 'package:ml_kit_barcode_scanner_example/result_screen.dart';

class FileScanner extends StatelessWidget {
  // ********************************* VARS ******************************** //

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final MlKitBarcodeScanner _scanner = MlKitBarcodeScanner();

  // ***************************** CONSTRUCTORS **************************** //

  FileScanner({required this.scaffoldKey});

  // ****************************** LIFECYCLE ****************************** //

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Pick file'),
        onPressed: () => _pickFile(context),
      ),
    );
  }

  // *************************** PRIVATE METHODS *************************** //

  _pickFile(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    String? message;

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final inputImage = InputImage.fromFilePath(filePath: file.path);

      try {
        final barcodes = await _scanner.scan(inputImage);

        if (barcodes.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ResultScreen(barcode: barcodes.first)));
        } else {
          message = 'No barcodes detected in that image.';
        }
      } on InvalidFilePathException catch (e) {
        print(e);
        message = 'Invalid file path provided.';
      } on FileNotFoundException catch (e) {
        print(e);
        message = 'Could not found file.';
      } on ProcessImageFailureException catch (e) {
        print(e);
        message = 'Error when processing the image.';
      } catch (e) {
        print(e);
        message = 'An unknown error happened.';
      }
    } else {
      message = 'Could not found any valid image.';
    }

    if (message != null) {
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
