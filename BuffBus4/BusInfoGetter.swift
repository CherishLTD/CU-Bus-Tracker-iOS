//
//  BusInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/13/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit


func getBusses() -> [Bus] {
    
    var req = getJSON("http://104.131.176.10:8080")
    var busses = [Bus]()
    
    var jsonError: NSError?
    if let json = NSJSONSerialization.JSONObjectWithData(req, options: nil, error: &jsonError) as? [String: AnyObject]
        //        var BusInfo = json["BusInfo"] as? [String: AnyObject] {
    {
        if let BusInfo = json["BusInfo"] as? [[String: AnyObject]] {
            println(BusInfo)
            for bus in BusInfo {
                var b = Bus(title: bus["equipmentID"] as! String,
                    locationName:"Soon",
                    coordinate: CLLocationCoordinate2D(latitude: bus["lat"] as! Double, longitude:bus["lng"] as! Double),
                    routeID:bus["routeID"] as! Int,
                    EquipmentID:bus["equipmentID"] as! String,
                    nextStopID: bus["nextStopID"] as! Int,
                    inService: true
                )
                busses.append(b)
                
            }
        }
        
    }
    else {
        println("NO")
    }
    
    return busses
    
    
}



func getJSON(urlToRequest: String) -> NSData{
    return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
}

func parseJSON(inputData: NSData) -> NSDictionary{
    var error: NSError?
    var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
    
    return boardsDictionary
}
