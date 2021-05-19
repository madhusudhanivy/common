//
//  LocationManager.swift
//  Melu
//
//  Created by apple on 07/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationManagerDelegate {
    func getCurrentLocationDetails(currentLocationCoodinates: CLLocationCoordinate2D)
}

internal final class LocationManager: NSObject {
    
    var delegate: LocationManagerDelegate!
    
    static let shared = LocationManager()
        
    lazy var locationManager : CLLocationManager = {
        
        let newLocationmanager = CLLocationManager()
        newLocationmanager.requestWhenInUseAuthorization()
        newLocationmanager.requestAlwaysAuthorization()
        newLocationmanager.desiredAccuracy = kCLLocationAccuracyBest
        return newLocationmanager
    }()
    
    var mapCenterLocationAddress : LocationAdress!
    var deviceLocation : CLLocation!

    func startUpdateLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    
    // MARK: - Location Details delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        debugPrint(locations.last!.coordinate)
        
        deviceLocation = locations.last!
        
        manager.stopUpdatingLocation()
        manager.stopUpdatingLocation()
        
        if delegate != nil {
            delegate.getCurrentLocationDetails(currentLocationCoodinates: locations.last!.coordinate)
        }
                
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    func setLocationInCenter(mapViewObj: MKMapView, location: CLLocationCoordinate2D) {
    
        // Do any additional setup after loading the view.
        mapViewObj.setCenter(location.self, animated: false)

        let region = MKCoordinateRegion( center: location.self, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapViewObj.setRegion(mapViewObj.regionThatFits(region), animated: false)
    
    }
    

    func getCenterLocationAddress(_ locationCoordinate: CLLocation, completionHandler: @escaping (_ data: Any) -> Void) {
        
        CLGeocoder().reverseGeocodeLocation(locationCoordinate, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                debugPrint("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]

                self.mapCenterLocationAddress = LocationAdress()
                self.mapCenterLocationAddress.location = locationCoordinate
                self.mapCenterLocationAddress.thoroughfare = pm!.thoroughfare ?? ""
                self.mapCenterLocationAddress.locality = pm!.locality ?? ""
                self.mapCenterLocationAddress.administrativeArea = pm!.administrativeArea ?? ""
                self.mapCenterLocationAddress.country = pm!.country ?? ""
                self.mapCenterLocationAddress.subLocality = pm!.subLocality ?? ""
                self.mapCenterLocationAddress.district = pm!.subAdministrativeArea ?? ""
                self.mapCenterLocationAddress.postalCode = pm!.postalCode ?? ""
                self.mapCenterLocationAddress.fullAddress = ""
                
                /*   ------- full address ----------   */
                if let subLocality = pm!.subLocality {
                    self.mapCenterLocationAddress.fullAddress = subLocality
                }
                if let locality = pm!.locality {
                    self.mapCenterLocationAddress.fullAddress = self.mapCenterLocationAddress.fullAddress! + ", " + locality
                }
                if let administrativeArea = pm!.administrativeArea {
                    self.mapCenterLocationAddress.fullAddress = self.mapCenterLocationAddress.fullAddress! + ", " + administrativeArea
                }
                if let country = pm!.country {
                    self.mapCenterLocationAddress.fullAddress = self.mapCenterLocationAddress.fullAddress! + ", " + country
                }
                if let postalCode = pm!.postalCode {
                    self.mapCenterLocationAddress.fullAddress = self.mapCenterLocationAddress.fullAddress! + " - " + postalCode
                }
                
                DispatchQueue.main.async {
                    completionHandler(self.mapCenterLocationAddress as Any)
                }
                                
            }
            else {
                #if DEBUG
                debugPrint("Problem with the data received from geocoder")
                #endif
            }
        })
        
    }
    
}
