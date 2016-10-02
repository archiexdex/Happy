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
    // Camera View
    var captureSession      : AVCaptureSession?
    var videoPreviewLayer   : AVCaptureVideoPreviewLayer?
    var stillImageOutput    : AVCaptureStillImageOutput?
    var locationManager     : LocationManager?
    
    // Other Views
    var theMirror           : UIButton! // mirror
    var theFrame            : UIImageView!
    var theSword            : UIImageView!
    var theGoast            : UIImageView!
    
    // Time
    var theTime             : Timer?
    var count               : Int?
    var interval            : Int = 7000
    
    // Flag
    var isGoastAppear       : Int = 0
    var isSwordAppear       : Int = 0
    
    // Audio
    var music               : MusicHandler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManager = LocationManager.sharedInstance
//        locationManager?.requestAlwaysInUse()
        self.theTime = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        self.count = 0
        
        // Camera
        self.viewSetting()
        
        // Mirror
        self.mirrorViewSetting()
        
        // Frame
        self.frameViewSetting()
        
        // Sword
        self.swordViewSetting()
        
        // Goast
        self.goastViewSetting()
        
        // music
        self.music = MusicHandler.sharedInstance
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
    
    func mirrorViewSetting() {
        
        let rect = CGRect(x: 344 , y: 850, width: 100, height: 100)
        self.theMirror = UIButton(frame: rect)
        let image = UIImage(named: "mirror.png")
        theMirror.setImage(image, for: .normal)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressGesture(sender:)))
        theMirror.addGestureRecognizer(longPress)
        
        self.view.addSubview(theMirror)
        
    }
    
    func frameViewSetting() {
        
        let image = UIImage(named: "frame.png")
        self.theFrame = UIImageView(image: image)
        self.theFrame.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.theFrame.alpha = 0
        
        self.view.addSubview(self.theFrame)
    }
    
    func swordViewSetting() {
        
        let rect = CGRect(x: 272, y: 240, width: 245, height: 48)
        let image = UIImage(named: "sword.png")
        self.theSword = UIImageView(image: image)
        self.theSword.frame = rect
        self.theSword.alpha = 1
        
        self.view.addSubview(self.theSword)
    }
    
    func goastViewSetting() {
      
        
        let rect = CGRect(x: 220 , y: 300 , width: 350, height: 500)
        let image = UIImage(named: "monster0.png")
        self.theGoast = UIImageView(image: image)
        self.theGoast.frame = rect
        self.theGoast.alpha = 0
        
        self.view.addSubview(self.theGoast)
        
    }
    
    
    // MARK: - Function
    func longPressGesture(sender : UILongPressGestureRecognizer){
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
            self.theFrame.alpha = 0
            self.theMirror.adjustsImageWhenDisabled = false
            self.viewDidAppear(true)
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            self.theFrame.alpha = 1
            self.theMirror.adjustsImageWhenDisabled = true
            self.viewDidAppear(true)
        }
    }
    
    func counter() {
        self.count = self.count! + 1
        
        if self.isGoastAppear == 15 {
            self.isSwordAppear  = 1
            self.interval = 2000
            
            self.theGoast.alpha = 1
            self.theSword.alpha = 0
            self.viewDidAppear(true)
        }
        
        if self.count == self.interval {
            if self.isSwordAppear == 0 {
                self.theSword.alpha = 1 - self.theSword.alpha
                
                self.viewDidAppear(true)
            }
            
            if self.isGoastAppear == 18 {
                self.theGoast.alpha = 1 - self.theGoast.alpha
                
                nextVC()
            }
            
            self.isGoastAppear = self.isGoastAppear + 1
            self.count = 0
        }
        
        
    }
    
    func nextVC () {
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
            
            DispatchQueue.main.async(execute: {
                //
                self.music?.stop()
                let ptr = self.storyboard?.instantiateViewController(withIdentifier: "FightViewController") as! FightViewController
                self.present(ptr, animated: true, completion: nil)
            })
        })
    }
    
    
    
}

extension ViewController : AVCaptureMetadataOutputObjectsDelegate {
    
}
