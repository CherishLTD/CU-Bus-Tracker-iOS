//
//  RouteInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation


func getRoutes() -> [Route] {
    
    let url = NSURL(string: "http://104.131.176.10:8080/routes")
    var routes = [Route]()

    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        var jsonError: NSError?
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [[String: AnyObject]]
        {
            let RouteInfo = json
            for route in RouteInfo {
                var b = Route(
                    id:route["id"] as! Int,
                    name:route["name"] as! String,
                    stops:route["stops"] as! [Int]
                )
                routes.append(b)
                
            }
        }
        APIManager.sharedInstance.setRoutes(routes)
        
      
    }
    task.resume()
    return routes
}