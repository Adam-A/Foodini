//
//  BarcodeViewController.swift
//  App
//
//  Created by Mark Nickerson on 11/23/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// Referenced: https://www.appcoda.com/simple-barcode-reader-app-swift/
//
// AVCaptureMetadataOutputObjectsDelegate is included
//     because "self" is the delegate for setMetadataObjectsDelegate and this class must conform to
//     AVCaptureMetadataOutputObjectsDelegate protocol
//

import UIKit
import AVFoundation
import Alamofire

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // Food Product structure (put into API.swift)
    struct FoodProduct: Codable {
        struct Hints: Codable {
            var food: Food
        }
        
        struct Food : Codable{
            var foodId: String
            var uri: String
            var label: String
            var nutrients: Nutrients
            var brand: String
            var category: String
            var categoryLabel: String
            var foodContentsLabel: String
        }
        
        struct Nutrients: Codable{
            var ENERC_KCAL: Double
        }
        
        var text: String
        var parsed: [String]
        var hints: [Hints]
        
        func getLabel() -> String{
            return hints[0].food.label
        }
    }
    
    struct APIerror: Codable {
        var error: String
        var message: String
    }
    
    
    
    // The current capture session,
    //     used to manage flow of data from input
    //     capture device (like captureDevice) to output (like metadataObject)
    var avSession: AVCaptureSession?
    
    // Preview layer to be used to display video on view controller as it is being captured
    var cameraPreview: AVCaptureVideoPreviewLayer?
    
    // "Window" for displaying output from the capture device
    @IBOutlet weak var cameraDisplay: UIView!
    
    // REMOVE: Temporary food display label
    @IBOutlet weak var foodDisplayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // REMOVE:
        foodDisplayLabel.isHidden = true
        
        // Create an av capture session
        avSession = AVCaptureSession()
        
        // Establish a video capture device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        // Create an input object from the device
        let deviceInput: AVCaptureDeviceInput?
        
        // If capture device exists, try to capture input from camptureDevice
        if let captureDevice = captureDevice {
            do{
                deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            } catch {
                print("Capture unavaliable")
                //self.navigationController?.popViewController(animated: true)
                return
            }
        } else {
            print ("No capture device")
            //self.navigationController?.popViewController(animated: true)
            return
        }
        
        // Unwrap avSession
        guard let avSession = avSession else { return }
        
        // If we can add input from the device, add it to the av session
        if let deviceInput = deviceInput{
            if avSession.canAddInput(deviceInput){
                avSession.addInput(deviceInput)
            } else {
                print("Cannot add input")
                //self.navigationController?.popViewController(animated: true)
                return
            }
        }
        
        // Create av metadata object to process the metadata from the av session
        let metadataObject = AVCaptureMetadataOutput()
        
        // If we can add output to the av session, add it
        if avSession.canAddOutput(metadataObject){
            avSession.addOutput(metadataObject)
            
            // When a metadata object is captured,
            //     send it to the delegate (self) and execute it on the (serial) main dispatch queue
            metadataObject.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // Set metadata object type to EAN13 barcode type
            metadataObject.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
        } else {
            print("Cannot add output")
            //self.navigationController?.popViewController(animated: true)
            return
        }
        
        // Set preview layer to the current av capture session (avSession)
        cameraPreview = AVCaptureVideoPreviewLayer(session: avSession)
        // Set frame rectangle equal to cameraDisplay's onscreen bounds
        cameraPreview?.frame = cameraDisplay.layer.bounds
        // Aspect fill the video preview layer to fit cameraDisplay's bounds
        cameraPreview?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        if let cameraPreview = cameraPreview{
            // Add cameraPreview layer as a sublayer to the cameraDisplay layer
            cameraDisplay.layer.addSublayer(cameraPreview)
            // Start the av capture session
            avSession.startRunning()
        } else {
            print("Cannot display camera preview")
            //self.navigationController?.popViewController(animated: true)
            return
        }
    }
    
    // Documentation: https://developer.apple.com/documentation/avfoundation/avcapturemetadataoutputobjectsdelegate/1389481-metadataoutput
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Stop the av capture session
        avSession?.stopRunning()
        
        // The first element of the collection output will contain the barcode information
        // we're looking for, but it must be cast as an AVMetadataMachineReadableCodeObject
        // in order for us to access the contents of the barcode image in machine readable code
        let barcode = metadataObjects.first as? AVMetadataMachineReadableCodeObject
        
        processBarcode(unprocessedBarcode: barcode?.stringValue ?? "error")
    }
    
    func processBarcode(unprocessedBarcode: String){
        // If the barcode is invalid, return
        if (unprocessedBarcode == "error"){
            print("Invalid barcode")
            //self.navigationController?.popViewController(animated: true)
            return
        }
        
        var trimmedBarcode = unprocessedBarcode
        
        // If the barcode is in EAN13 format, process it into a UPC format
        if (unprocessedBarcode.count == 13 && unprocessedBarcode.hasPrefix("0")){
            trimmedBarcode = String(unprocessedBarcode.suffix(12))
        }
        
        // Make API call (put into API.swift)
        let appID = "9ca52e0d"
        let appKey = "7dade37c47154913ca172a01f0e48921"
        
        Alamofire.request("https://api.edamam.com/api/food-database/parser?upc=\(trimmedBarcode)&app_id=\(appID)&app_key=\(appKey)").responseJSON { response in
            
            guard let data = response.data else { return }
            
            do {
                let product = try JSONDecoder().decode(FoodProduct.self, from: data)
                // REMOVE:
                self.foodDisplayLabel.isHidden = false
                self.foodDisplayLabel.text = product.getLabel()
                print(product.getLabel())
                
            } catch {
                // Make into a function
                do{
                    let error = try JSONDecoder().decode(APIerror.self, from: data)
                    print(error.message)
                    
                } catch {
                    print("An unknown error has occured")
                    //self.navigationController?.popViewController(animated: true)
                    return
                }
                
            }
            
            
        }
    }
}
