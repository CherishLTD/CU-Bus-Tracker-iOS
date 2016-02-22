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
    
    let url = NSURL(string: "http://cherishapps.me:8080/buses")
    var buses = [Bus]()
    let options = NSJSONReadingOptions(rawValue: 0);
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        if (error != nil) {
            sleep(2)
            getBuses()
            return
        }
        do {
        if let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: options) as? [[String: AnyObject]]
                //        var BusInfo = json["BusInfo"] as? [String: AnyObject] {
            {
                let BusInfo = json
                    for bus in BusInfo {
                        let b = Bus(title: "bus",
                            locationName:"",
                            coordinate: CLLocationCoordinate2D(latitude: bus["lat"] as! Double, longitude:bus["lng"] as! Double),
                            routeID:bus["routeID"] as! Int,
                            inService: true
                        )
                        buses.append(b)
                    }
                }
        }
        
        APIManager.sharedInstance.setBuses(buses)
    }
    
    task.resume()
    return buses
}



func parseJSON(inputData: NSData) -> NSDictionary{
    var error: NSError?
    let boardsDictionary: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
    
    return boardsDictionary
}
