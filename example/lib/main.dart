import 'package:flutter/material.dart';
import 'package:ml_kit_barcode_scanner_example/file.dart';
import 'package:ml_kit_barcode_scanner_example/scanner.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // ********************************* VARS ******************************** //

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  int _selectedIndex = 0;

  // ****************************** LIFECYCLE ****************************** //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ML Kit Barcode Scanner'),
        ),
        body: _getCurrentItem(),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera), label: 'From camera'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file), label: 'From file'),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) => setState(() => {_selectedIndex = index})),
      ),
    );
  }

  // *************************** PRIVATE METHODS *************************** //

  _getCurrentItem() {
    if (_selectedIndex == 0) {
      return CameraScanner();
    } else {
      return FileScanner(scaffoldKey: _scaffoldKey);
    }
  }
}
