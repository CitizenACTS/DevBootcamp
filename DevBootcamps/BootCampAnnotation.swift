//
//  BootCampAnnotation.swift
//  DevBootcamps
//
//  Created by Pierre De Pingon on 01/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import Foundation
import MapKit


class BootCampAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
    }
}
