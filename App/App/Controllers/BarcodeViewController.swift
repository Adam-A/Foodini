//
//  BarcodeViewController.swift
//  App
//
//  Created by Mark Nickerson on 11/23/18.
//  Copyright © 2018 Can I Graduate Already, LLC. All rights reserved.
//
// Referenced https://www.appcoda.com/simple-barcode-reader-app-swift/
//

import UIKit
import AVFoundation

class BarcodeViewController: UIViewController {
    
    var avSession: AVCaptureSession?
    var cameraPreview: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var cameraDisplay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an av capture session
        avSession = AVCaptureSession()
        
        // Establish a capture device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        let deviceInput: AVCaptureDeviceInput?
        
        do{
            if let captureDevice = captureDevice{
                deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            } else {
                print("No device input")
                return
            }
            
        } catch {
            print("Capture unavaliable")
            return
        }
        
        // If we can add input from the device, add it to the session
        if let avSession = avSession, let deviceInput = deviceInput{
            if avSession.canAddInput(deviceInput){
                avSession.addInput(deviceInput)
            } else {
                print("Cannot add input")
            }
        }
        
        if let avSession = avSession{
            cameraPreview = AVCaptureVideoPreviewLayer(session: avSession)
            cameraPreview?.frame = cameraDisplay.layer.bounds
            cameraPreview?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            if let cameraPreview = cameraPreview{
                cameraDisplay.layer.addSublayer(cameraPreview)
                avSession.startRunning()
            } else {
                print("Cannot display camera preview")
            }
        }
        
        
        
        
        
        
        
        
    }

}
