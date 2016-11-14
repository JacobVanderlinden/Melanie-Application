//
//  CameraViewController.swift
//  Melanie
//
//  Created by Ian Mobbs on 11/13/16.
//  Copyright © 2016 Ian Mobbs. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var diagnoseButton: UIButton!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCaptureStillImageOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var imageToSend: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == AVCaptureDevicePosition.Back {
                do {
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input) {
                        captureSession.addInput(input)
                        sessionOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                        
                        if captureSession.canAddOutput(sessionOutput) {
                            captureSession.addOutput(sessionOutput)
                            captureSession.startRunning()
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                            cameraView.layer.addSublayer(previewLayer)
                            previewLayer.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
                            previewLayer.bounds = cameraView.frame
                        }
                    }
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cameraToDetail" {
            let destination = segue.destinationViewController as! DiagnosisViewController
            destination.moleImage = imageToSend
        }
    }

    @IBAction func diagnoseButtonPressed(sender: AnyObject) {
        if let videoConnection = sessionOutput.connectionWithMediaType(AVMediaTypeVideo) {
            sessionOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                    buffer, error in let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                    // UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData)!, nil, nil, nil)
                
                    self.imageToSend = UIImage(data: imageData)
                    self.performSegueWithIdentifier("cameraToDetail", sender: self)
                
                })
        }
    
        
    }
    


}
