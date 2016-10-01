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

    // MARK: - IBOutlet
    
    // MARK: - Variable
    var locationManager : LocationManager?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = LocationManager.sharedInstance
        locationManager?.requestAlwaysInUse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Function
    

    func startGM() {

        let gps = locationManager?.getLocation()
        if gps == nil {
            print("GPS Fail")
            return
        }
        let camera = GMSCameraPosition.camera(withLatitude: (gps?.latitude)! , longitude: (gps?.longitude)!, zoom: 6)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake( (gps?.latitude)!, (gps?.longitude)!)
        marker.icon = UIImage(named: "roo.png")
        marker.title = locationManager?.getCountry()
        marker.map = mapView
        

    }
    
    
    // MARK: - IBAction
    @IBAction func startToGetGPS(_ sender: AnyObject) {
        
        locationManager?.start()
        startGM()
        
    }

}
