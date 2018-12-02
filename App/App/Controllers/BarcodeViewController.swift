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

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // The current capture session,
    //     used to manage flow of data from input
    //     capture device (like captureDevice) to output (like metadataObject)
    var avSession: AVCaptureSession?
    
    // Preview layer to be used to display video on view controller as it is being captured
    var cameraPreview: AVCaptureVideoPreviewLayer?
    
    // "Window" for displaying output from the capture device
    @IBOutlet weak var cameraDisplay: UIView!
    
    // Variables used to add product to pantry
    var product = Product()
    var delegate: UpdateListDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an av capture session
        avSession = AVCaptureSession()
        
        // Establish a video capture device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        // Create an input object from the device
        var deviceInput: AVCaptureDeviceInput?
        
        // If capture device exists, try to capture input from camptureDevice
        if let captureDevice = captureDevice {
            do{
                deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            } catch {
                print("Capture unavaliable")
                // Spawn error popup
                SpawnPopup(message: "This device can't currently capture.")
                
            }
        } else {
            print ("No capture device")
            // Spawn error popup
            SpawnPopup(message: "This device has no capture device.")
        }
        
        // Unwrap avSession
        guard let avSession = avSession else { return }
        
        // If we can add input from the device, add it to the av session
        if let deviceInput = deviceInput{
            if avSession.canAddInput(deviceInput){
                avSession.addInput(deviceInput)
            } else {
                print("Cannot add input")
                // Spawn error popup
                SpawnPopup(message: "Cannot add input to this device, please try again later.")
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
            // Spawn error popup
            SpawnPopup(message: "Cannot add output to this device, please try again later.")
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
            SpawnPopup(message: "Cannot display camera preview.")
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
            SpawnPopup(message: "We encountered an error while processing the barcode, please try again.")
        }
        
        var trimmedBarcode = unprocessedBarcode
        
        // If the barcode is in EAN13 format, process it into a UPC format
        if (unprocessedBarcode.count == 13 && unprocessedBarcode.hasPrefix("0")){
            trimmedBarcode = String(unprocessedBarcode.suffix(12))
        }
        
        // Make API call
        API.ApiCall(barcode: trimmedBarcode) { (response, error) in
            if (error == nil && response != nil) {
                if let response = response{
                    self.pushEditItemViewController(foodProduct: response)
                }
            } else {
                if let error = error{
                    print("Error: \(error.message)")
                    // Spawn pop up error
                    self.SpawnPopup(message: "We can't find the item you searched for, please enter it manually.")
                }
            }
        }
    }
    
    func SpawnPopup(message: String){
        let popup = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        popup.addAction(UIAlertAction(title: "Return", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func pushEditItemViewController(foodProduct: API.FoodProduct){
        // Create and push EditItemViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "editItemViewController") as! EditItemViewController
    
        // Set EditItemViewController vars
        self.product.productName = foodProduct.getLabel()
        viewController.product = self.product
        viewController.delegate = self.delegate
        viewController.editCell = false
    
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
