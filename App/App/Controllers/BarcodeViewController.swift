//
//  BarcodeViewController.swift
//  App
//
//  Created by Mark Nickerson on 11/23/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
// Referenced: https://www.appcoda.com/simple-barcode-reader-app-swift/
//
// AVCaptureMetadataOutputObjectsDelegate is included
//     because "self" is the delegate for setMetadataObjectsDelegate and this class must conform to
//     AVCaptureMetadataOutputObjectsDelegate protocol
<<<<<<< HEAD
=======
// Referenced https://www.appcoda.com/simple-barcode-reader-app-swift/
>>>>>>> Added realtime camera display to barcode view
=======
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
//

import UIKit
import AVFoundation

<<<<<<< HEAD
<<<<<<< HEAD
class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // The current capture session,
    //     used to manage flow of data from input
    //     capture device (like captureDevice) to output (like metadataObject)
    var avSession: AVCaptureSession?
    
    // Preview layer to be used to display video on view controller as it is being captured
    var cameraPreview: AVCaptureVideoPreviewLayer?
    
    // "Window" for displaying output from the capture device
=======
class BarcodeViewController: UIViewController {
=======
class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
    
    // The current capture session,
    //     used to manage flow of data from input
    //     capture device (like captureDevice) to output (like metadataObject)
    var avSession: AVCaptureSession?
    
    // Preview layer to be used to display video on view controller as it is being captured
    var cameraPreview: AVCaptureVideoPreviewLayer?
    
<<<<<<< HEAD
>>>>>>> Added realtime camera display to barcode view
=======
    // "Window" for displaying output from the capture device
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
    @IBOutlet weak var cameraDisplay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an av capture session
        avSession = AVCaptureSession()
        
<<<<<<< HEAD
<<<<<<< HEAD
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
                return
            }
        } else {
            print ("No capture device")
            return
        }
        
        // Unwrap avSession
        guard let avSession = avSession else { return }
        
        // If we can add input from the device, add it to the av session
        if let deviceInput = deviceInput{
=======
        // Establish a capture device
=======
        // Establish a video capture device
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        // Create an input object from the device
        let deviceInput: AVCaptureDeviceInput?
        
        // If capture device exists, try to capture input from camptureDevice
        if let captureDevice = captureDevice {
            do{
                deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            } catch {
                print("Capture unavaliable")
                return
            }
        } else {
            print ("No capture device")
            return
        }
        
<<<<<<< HEAD
        // If we can add input from the device, add it to the session
        if let avSession = avSession, let deviceInput = deviceInput{
>>>>>>> Added realtime camera display to barcode view
=======
        // Unwrap avSession
        guard let avSession = avSession else { return }
        
        // If we can add input from the device, add it to the av session
        if let deviceInput = deviceInput{
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
            if avSession.canAddInput(deviceInput){
                avSession.addInput(deviceInput)
            } else {
                print("Cannot add input")
<<<<<<< HEAD
<<<<<<< HEAD
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
            return
        }
        
        var trimmedBarcode = unprocessedBarcode
        
        // If the barcode is in EAN13 format, process it into a UPC format
        if (unprocessedBarcode.count == 13 && unprocessedBarcode.hasPrefix("0")){
            trimmedBarcode = String(unprocessedBarcode.suffix(12))
        }
        
        // Make API call here
        print("Found a barcode: \(trimmedBarcode)!")
    }
    
    
=======
=======
                return
>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
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
            return
        }
        
        var trimmedBarcode = unprocessedBarcode
        
        // If the barcode is in EAN13 format, process it
        if (unprocessedBarcode.count == 13 && unprocessedBarcode.hasPrefix("0")){
            trimmedBarcode = String(unprocessedBarcode.suffix(12))
        }
        
        // Make API call here
        print("Found a barcode: \(trimmedBarcode)!")
    }

<<<<<<< HEAD
>>>>>>> Added realtime camera display to barcode view
=======

>>>>>>> Added metadata output from capture device, barcode capturing, and EAN13 barcode processing for use as UPC format
}
