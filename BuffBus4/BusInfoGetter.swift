//
//  BusInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/13/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit


func getBuses() -> [Bus] {
    
    let url = NSURL(string: "http://104.131.176.10:8080/buses")
    var buses = [Bus]()
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var jsonError: NSError?
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [[String: AnyObject]]
                //        var BusInfo = json["BusInfo"] as? [String: AnyObject] {
            {
                let BusInfo = json
                    for bus in BusInfo {
                        var b = Bus(title: "bus",
                            locationName:"",
                            coordinate: CLLocationCoordinate2D(latitude: bus["lat"] as! Double, longitude:bus["lng"] as! Double),
                            routeID:bus["routeID"] as! Int,
                            inService: true
                        )
                        buses.append(b)
                    }
                }
        APIManager.sharedInstance.setBuses(buses)
    }
    
    task.resume()
    return buses
}



func parseJSON(inputData: NSData) -> NSDictionary{
    var error: NSError?
    var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
    
    return boardsDictionary
}
