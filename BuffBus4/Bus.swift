//
//  Bus.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/13/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit


class Bus: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let routeID: Int
    let inService: Bool
    
    
    init (title: String, locationName: String, coordinate: CLLocationCoordinate2D, routeID: Int, inService: Bool) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.routeID = routeID
        self.inService = inService
        self.subtitle = locationName
        super.init()
    }
    
    
    
}