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
    
    let url = NSURL(string: "http://104.131.176.10:8080/stops")
    var stops = [Stop]()
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        var jsonError: NSError?
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [[String: AnyObject]]
        {
            let StopInfo = json
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
                    var b = Stop(title: stop["name"] as! String,
                        id:stop["id"] as! Int,
                        coordinate: CLLocationCoordinate2D(latitude: stop["lat"] as! Double, longitude:stop["lng"] as! Double),
                        nextBusTimes: [-1, -2]
                    )
                    stops.append(b)
                    
                }
                
            }
        }
        APIManager.sharedInstance.setStops(stops)
    }
    task.resume()
    return stops
    
}


