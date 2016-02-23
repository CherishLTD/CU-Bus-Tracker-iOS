//
//  Route.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation


class Route: NSObject {
    let id: String
    let name: String
    let stops: [Int]
    
    init (id:String, name: String, stops:[Int]) {
        self.id = id
        self.name = name
        self.stops = stops
        
        super.init()
        
    }
    
}