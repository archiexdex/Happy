//
//  LocationManager.swift
//  SystemSensor
//
//  Created by 楊信之 on 10/1/16.
//  Copyright © 2016 楊信之. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {

    // MARK: - Variable
    var locationManager         : CLLocationManager!
    var nowLocation             : CLLocation!
    var nowPlaceMark            : CLPlacemark?
    var isFirstLocationReceived : Bool!
    
    // MARK: - Singleton
    class var sharedInstance : LocationManager{
        struct Singleton {
            static let instance = LocationManager()
        }
        return Singleton.instance
    }
    
    // MARK: - Init
    override init() {
        //
        locationManager = CLLocationManager()
        isFirstLocationReceived = true
    }
    
    // MARK: - Ask Permission
    func requestWhenInUse() {
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.activityType = .other
        locationManager.delegate     = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestAlwaysInUse() {
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.activityType = .other
        locationManager.delegate     = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - Function
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        
        if isFirstLocationReceived == true {
            return nil
        }
        let lati = nowLocation.coordinate.latitude
        let long = nowLocation.coordinate.longitude
        let gps  = nowLocation.coordinate
//        return String().appendingFormat("(%3f,%3f)", lati, long)
        
        return gps
    }
    
    func getCountry() -> String {
        
        if isFirstLocationReceived == true || nowPlaceMark == nil {
            return "UNKNOW"
        }
        
        let country = (nowPlaceMark?.country)!
        
        return country
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Receive Data
        nowLocation = locations.last
        isFirstLocationReceived = false
        
        // Get Place Mark
        CLGeocoder().reverseGeocodeLocation(nowLocation) { (placeMarks, error) in
            //
            self.nowPlaceMark = placeMarks?.first
        }
        
    }
}
