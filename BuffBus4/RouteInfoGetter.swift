//
//  RouteInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation


func getRoutes() -> [Route] {
    
    var req = getJSON("http://104.131.176.10:8080/buses")
    var busses = [Route]()
    
    var jsonError: NSError?
    if let json = NSJSONSerialization.JSONObjectWithData(req, options: nil, error: &jsonError) as? [[String: AnyObject]]
        //        var BusInfo = json["BusInfo"] as? [String: AnyObject] {
    {
        let RouteInfo = json
        for route in RouteInfo {
            var b = Route(
                id:route["id"] as! Int,
                name:route["name"] as! String,
                stops:route["stops"] as! [Int]
                
//                self.id = id
//                self.name = name
//                self.stops = stops
            )
            busses.append(b)
            
        }
    }
    
    return busses
}