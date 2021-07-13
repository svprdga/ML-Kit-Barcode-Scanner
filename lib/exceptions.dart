part of ml_kit_barcode_scanner;

class InvalidFilePathException implements Exception {
  final String message;

  InvalidFilePathException({required this.message});

  @override
  String toString() => message;
}

class FileNotFoundException implements Exception {
  final String message;

  FileNotFoundException({required this.message});

  @override
  String toString() => message;
}

class ProcessImageFailureException implements Exception {
  final String message;

  ProcessImageFailureException({required this.message});

  @override
  String toString() => message;
}