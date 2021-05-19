//
//  LocationAdress.swift
//  Melu
//
//  Created by apple on 07/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import CoreLocation

class LocationAdress: NSObject {
    
    var location: CLLocation?
    var thoroughfare : String?
    var locality: String?
    var country: String?
    var administrativeArea : String?
    var subLocality : String?
    var district : String?
    var fullAddress : String?
    var postalCode : String?

}
