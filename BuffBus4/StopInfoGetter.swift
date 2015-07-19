//
//  StopInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit


func getStops() -> [Stop] {
    
    var req = getJSON("http://104.131.176.10:8080/stops")
    var stops = [Stop]()
    
    var jsonError: NSError?
    if let json = NSJSONSerialization.JSONObjectWithData(req, options: nil, error: &jsonError) as? [[String: AnyObject]]
    {
        let StopInfo = json
        println(StopInfo)
        for stop in StopInfo {
            
            if let nextBusTimes = stop["nextBusTimes"] as?  [Int] {
                var b = Stop(title: stop["name"] as! String,
                    id:stop["id"] as! Int,
                    coordinate: CLLocationCoordinate2D(latitude: stop["lat"] as! Double, longitude:stop["lng"] as! Double),
                    nextBusTimes: nextBusTimes
                )
                stops.append(b)
            }
            else {
                println("YES")
                var b = Stop(title: stop["name"] as! String,
                    id:stop["id"] as! Int,
                    coordinate: CLLocationCoordinate2D(latitude: stop["lat"] as! Double, longitude:stop["lng"] as! Double),
                    nextBusTimes: [-1]
                )
                stops.append(b)
                
            }
            
        }
    }
    
    return stops
}


