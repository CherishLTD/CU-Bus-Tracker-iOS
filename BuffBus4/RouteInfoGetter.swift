//
//  RouteInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation


func getRoutes() -> [Route] {
    
    let url = NSURL(string: "http://cherishapps.me:8080/routes")
    var routes = [Route]()
    let options = NSJSONReadingOptions(rawValue: 0);

    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        var json: [[String: AnyObject]]?
        if (error != nil) {
            sleep(2)
            getRoutes()
            return
        }
        do
        {
        json = try NSJSONSerialization.JSONObjectWithData(data!, options:options ) as? [[String: AnyObject]]
            
               
                let RouteInfo = json
                
                for route in RouteInfo! {
                    let b = Route(
                        id:route["id"] as! Int,
                        name:route["name"] as! String,
                        stops:route["stops"] as! [Int]
                    )
                    routes.append(b)
                    
                }
                
            
        }
        catch _ {
            print("HI")
        }
        
        APIManager.sharedInstance.setRoutes(routes)
        
        
        
      
    }
    task.resume()
    return routes
}