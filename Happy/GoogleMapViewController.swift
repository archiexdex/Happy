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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = LocationManager.sharedInstance
        
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
        
        // GMSMapView
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake( (gps?.latitude)!, (gps?.longitude)!)
        marker.icon = UIImage(named: "roo.png")
        marker.map = mapView
        

    }
    
    func alertInfo() {
        
    }
    
    // MARK: - IBAction
    @IBAction func startToGetGPS(_ sender: AnyObject) {
        
        locationManager?.start()
        startGM()
        
    }

}

extension GoogleMapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //
        print(">> \(mapView) \n>>>\(marker.userData)")
        let flag = mapView.clipsToBounds
        
        if flag {
            let ptr = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
                
                DispatchQueue.main.async(execute: {
                    //
                    self.present(ptr, animated: true, completion: nil)
                })
            })
            
            
        }
        
        
        return flag
    }
}
