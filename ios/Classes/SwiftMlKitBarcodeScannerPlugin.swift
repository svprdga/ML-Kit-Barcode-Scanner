import Flutter
//import MLImage
//import MLKit
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
        
        let width = list[2] as! Int?
        let height = list[3] as! Int?
        let rotation = list[4] as! Int?
        
        // TODO
        let path: String? = nil
        
        // Check arguments
        let checkByteArray = type == inputImageTypeByteArray && (
            bytes == nil || width == nil || height == nil || rotation == nil
        )
        let checkFilePath = type == inputImageTypeUri && (
            path == nil
        )
        
        if (checkByteArray || checkFilePath) {
            result(FlutterError(code: self.errorScanInputImageInvalidArguments, message: "Invalid arguments", details: nil))
        }
        
        // Prepare InputImage
        let data = NSData(bytes: bytes, length: bytes!.count)
        let uiImage = UIImage(data: data as Data)
        
        /*let image = VisionImage(image: uiImage)
        visionImage.orientation = image.imageOrientation*/
        
        /*let image = VisionImage(buffer: sampleBuffer)
        image.orientation = imageOrientation(
            deviceOrientation: UIDevice.current.orientation,
            cameraPosition: cameraPosition)
        */
        // TODO
        result(nil)
    }
    
    /*private func imageOrientation(
        deviceOrientation: UIDeviceOrientation,
        cameraPosition: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
        switch deviceOrientation {
        case .portrait:
            return cameraPosition == .front ? .leftMirrored : .right
        case .landscapeLeft:
            return cameraPosition == .front ? .downMirrored : .up
        case .portraitUpsideDown:
            return cameraPosition == .front ? .rightMirrored : .left
        case .landscapeRight:
            return cameraPosition == .front ? .upMirrored : .down
        case .faceDown, .faceUp, .unknown:
            return .up
        }
    }*/
    
}
