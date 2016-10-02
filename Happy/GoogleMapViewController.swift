//
//  GoogleMapViewController.swift
//  Happy
//
//  Created by 楊信之 on 10/1/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {

    // MARK: - Variable
    var locationManager : LocationManager?
    var gps             : CLLocationCoordinate2D?
    var mapView         : GMSMapView?
    var camera          : GMSCameraPosition?
    var goastList       : [CLLocationCoordinate2D] = []
    var isGoastAppear   : Bool = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // location setting
        locationManager = LocationManager.sharedInstance
        locationManager?.requestAlwaysInUse()
        goastList.append(CLLocationCoordinate2D(latitude: 25.051372,longitude: 121.553045) )
        goastList.append(CLLocationCoordinate2D(latitude: 25.051510,longitude: 121.554134) )
        goastList.append(CLLocationCoordinate2D(latitude: 25.051346,longitude: 121.549569) )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGM()  
    }
    
    // MARK: - Function
    func startGM() {

        // google map setting
        camera = GMSCameraPosition.camera(withLatitude: Constants().startLocation.latitude, longitude: Constants().startLocation.longitude , zoom: Float(Constants().startZoom) )
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        mapView!.isMyLocationEnabled = true
        mapView?.setMinZoom(17.219, maxZoom: 19.87)
        mapView!.delegate = self
        self.view = mapView
     
    }
    
    func generate() {
        
        for ptr in 0..<self.goastList.count {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake( goastList[ptr].latitude, goastList[ptr].longitude)
            marker.icon = UIImage(named: "123.png")
            marker.map = mapView
        }
        
    }
    
    // TODO: Degenerate
    func deGenerate() {
        
        
    }
    
    func alertInfo() {
        
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "done", style: .cancel) { (action) in
            //
            let ptr = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
                
                DispatchQueue.main.async(execute: {
                    //
                    
                    self.present(ptr, animated: true, completion: nil)
                })
            })
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .default) { (action) in
            //
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - IBAction
    @IBAction func startToGetGPS(_ sender: AnyObject) {
//        locationManager?.start()
        startGM()
    }

}

// MARK: - GMSMapViewDelegate
extension GoogleMapViewController : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //
        print(">> \(mapView) \n>>>\(marker.userData)")
        let flag = mapView.clipsToBounds
        print("my location\(mapView.myLocation)")
        print("camera zoom \(self.mapView?.camera.zoom)")
        
        
        if flag {
            alertInfo()
        }
        
        
        return flag
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //
        let zoom = self.mapView?.camera.zoom
        
        print("camera zoom \(zoom)")
        
        if zoom! > Float(18.442) && self.isGoastAppear == false {
            isGoastAppear = true
            generate()
        }
        else {
            isGoastAppear = false
            deGenerate()
        }
        
    }
    
}
