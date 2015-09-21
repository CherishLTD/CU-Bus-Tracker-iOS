//
//  Stop.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit

class Stop: NSObject, MKAnnotation {
    let id : Int
    let title : String?
    let coordinate : CLLocationCoordinate2D
    let nextBusTimes : [String: [Int]]
    var subtitle : String?

    init (title: String, id: Int, coordinate: CLLocationCoordinate2D, nextBusTimes: [String: [Int]]) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
        self.nextBusTimes = nextBusTimes
        self.subtitle = ""
        
        super.init()
        
    }
    
    func setNewSubtitle(newSubTitle: String) {
        self.subtitle = newSubTitle
    }
    
}