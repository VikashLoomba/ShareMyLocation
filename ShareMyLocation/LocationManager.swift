//
//  LocationManager.swift
//  ShareMyLocation
//
//  Created by Vikash Loomba on 2/2/16.
//  Copyright © 2016 Loomba Apps. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {

    //Function to get Location
    func getCurrentLocation(locationManager: CLLocationManager)-> CLLocation {
        guard var location: CLLocation = locationManager.location! else {
            print("Could not get location");
        }
        return location;
    }
    
    
    
    
}