//
//  APIManager.swift
//  BuffBus4
//
//  Created by jferge on 7/31/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation


class APIManager : NSObject {
    private var buses : [Bus]?
    private var routes : [Route]?
    private var stops : [Stop]?
    
    class var sharedInstance : APIManager {
        struct Singleton {
            static let instance = APIManager()
        }
        return Singleton.instance
    }
    
    
    override init() {
        self.buses = nil
        self.routes = nil
        self.stops = nil
        

    }
    func getBuses() -> [Bus] {
        return self.buses!
    }
    func setBuses(newBuses: [Bus]) {
        self.buses = newBuses
    }
    // Every once in a while it crashes here unwrapping a nil value
    func getRoutes() -> [Route] {
        return self.routes!
    }
    func getStops() -> [Stop]? {
        return self.stops
    }
    func setStops(newStops:[Stop]) {
        self.stops = newStops
    }
    func setRoutes(newRoutes:[Route]) {
        self.routes = newRoutes
    }
}