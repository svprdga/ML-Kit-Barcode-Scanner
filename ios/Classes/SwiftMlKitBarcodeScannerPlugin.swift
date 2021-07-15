import Flutter
import MLKitVision
import MLKitBarcodeScanning

public class SwiftMlKitBarcodeScannerPlugin: NSObject, FlutterPlugin {
    
    // Constants
    
    private let nativeScanInputImage = "scan_input_image"
    private let errorScanInputImageInvalidArguments = "error_scan_input_image_invalid_arguments"
    private let errorScanInputImageParseUri = "error_scan_input_image_parse_uri"
    private let errorScanInputImageFileNotFound = "error_scan_input_image_file_not_found"
    private let errorScanInputImageUnknownType = "error_scan_input_image_unknown_type"
    private let errorScanInputImageProcessFailure = "error_scan_input_image_process_failure"
    private let errorScanInputImageInvalidMetadata = "error_scan_input_image_invalid_metadata"
    
    private let inputImageTypeByteArray = 0
    private let inputImageTypeUri = 1
    
    // Public methods
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ml_kit_barcode_scanner", binaryMessenger: registrar.messenger())
        let instance = SwiftMlKitBarcodeScannerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method){
        case self.nativeScanInputImage:
            scanInputImage(call: call, result: result)
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Private methods
    
    private func scanInputImage(call: FlutterMethodCall, result: FlutterResult) {
        
        // Get arguments
        let list = call.arguments as! [Any]
        let type = list[0] as! Int?
        
        let uintInt8List = list[1] as! FlutterStandardTypedData?
        var bytes: [UInt8]? = nil
        if (uintInt8List != nil && uintInt8List?.data != nil) {
            bytes = [UInt8](uintInt8List!.data)
        }
        
        let format = list[2] as! Int?
        let width = list[3] as! Int?
        let height = list[4] as! Int?
        let rotation = list[5] as! Int?
        let planes = list[6] as! Array<Dictionary<String, Any>>?
        
        // TODO
        let path: String? = nil
        
        // Check arguments
        let checkByteArray = type == inputImageTypeByteArray && (
            bytes == nil || width == nil || height == nil || rotation == nil || planes == nil
        )
        let checkFilePath = type == inputImageTypeUri && (
            path == nil
        )
        
        if (checkByteArray || checkFilePath) {
            result(FlutterError(code: self.errorScanInputImageInvalidArguments, message: "Invalid arguments", details: nil))
        }
        
        // Prepare InputImage
        let data = Data(bytes!)
        
        if (planes.count == 0) {
            result(FlutterError(code: self.errorScanInputImageInvalidMetadata, message: "No planes were found, cannot scan.", details: nil))
        } else if (planes.count == 1) {
            let pixelBuffer = createPixelBufferFromBytes(width: width!, height:height!, data:  data.bytes, bytes: planes![0]["bytes"] as! Int)
        }
        
        // TODO
        result(nil)
    }
    
    private func createPixelBufferFromBytes(
        width: size_t,
        height: size_t,
        format: FourCharCode,
        data: UnsafeMutableRawPointer,
        bytes: Int
    ) -> CVPixelBuffer? {
        var pxBuffer: CVPixelBuffer? = nil
        
        CVPixelBufferCreateWithBytes(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32BGRA,
            data,
            bytes,
            nil,
            nil,
            nil,
            &pxBuffer)
        
        return pxBuffer
    }
}
