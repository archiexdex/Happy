//
//  ViewController.swift
//  Happy
//
//  Created by 楊信之 on 10/1/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    // MARK: - Variable
    var captureSession      : AVCaptureSession?
    var videoPreviewLayer   : AVCaptureVideoPreviewLayer?
    var stillImageOutput    : AVCaptureStillImageOutput?
    var locationManager     : LocationManager?
    var theButton           : UIButton!
    var theBiggerView       : UIImageView!
    var theArrow            : UIImageView!
//    var theTime             : NSTimeZone!
//    var timeZone            : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManager = LocationManager.sharedInstance
//        locationManager?.requestAlwaysInUse()
        
        self.viewSetting()
        self.buttonSetting()
        self.biggerViewSetting()
        self.arrowViewSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - View Setting
    func viewSetting() {
        
        captureSession = AVCaptureSession()
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var input: AVCaptureDeviceInput!
        var error:NSError?
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil &&  (captureSession?.canAddInput(input))!  {
            captureSession?.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        
        if (captureSession?.canAddOutput(stillImageOutput))! {
            captureSession?.addOutput(stillImageOutput)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = self.view.layer.bounds
        self.view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
    }
    
    func buttonSetting() {
        
        let rect = CGRect(x: 384, y: 900, width: 50, height: 50)
        self.theButton = UIButton(frame: rect)
        let image = UIImage(named: "roo.png")
        theButton.setImage(image, for: .normal)
        theButton.backgroundColor = .black
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressGesture(sender:)))
        theButton.addGestureRecognizer(longPress)
        
        self.view.addSubview(theButton)
        
    }
    
    func biggerViewSetting() {
        
        let rect = CGRect(x: 384, y: 750, width: 75, height: 100)
        self.theBiggerView = UIImageView(image: UIImage(named: "roo.png"))
        self.theBiggerView.frame = rect
        // Set
        self.theBiggerView.alpha = 0
        self.view.addSubview(self.theBiggerView)
    }
    
    func longPressGesture(sender : UILongPressGestureRecognizer){
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
            self.theBiggerView.alpha = 0
            self.viewDidAppear(true)
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            self.theBiggerView.alpha = 1
            self.viewDidAppear(true)
        }
    }
    
    func arrowViewSetting() {
        
        let image = UIImage(named: "arrow.png")
        self.theArrow = UIImageView(image: image)
        self.theArrow.frame = CGRect(x: 192, y: 252, width: 256, height: 256)
        self.view.addSubview(theArrow)
        
    }
    
    
    
}

extension ViewController : AVCaptureMetadataOutputObjectsDelegate {
    
}
