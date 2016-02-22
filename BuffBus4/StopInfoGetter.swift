//
//  StopInfoGetter.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit


func getStops(view : UIViewController, callback: (() -> Void)?) -> [Stop] {
    let url = NSURL(string: "http://localhost:3000/stops")
    var stops = [Stop]()
    let options = NSJSONReadingOptions(rawValue: 0);
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        var json: [[String: AnyObject]]?
        if (error != nil) {
            sleep(2)
            getStops(view, callback: callback)
            return
        }
        do {
            json =  try NSJSONSerialization.JSONObjectWithData(data!, options: options) as? [[String: AnyObject]]
            
                let StopInfo = json
                for stop in StopInfo! {
                    
                    if let nextBusTimes = stop["nextBusTimes"] as?  [String: [Int]]  {
                        
                        if nextBusTimes.count > 0 {
                        let b = Stop(title: stop["name"] as! String,
                            id:stop["id"] as! Int,
                            coordinate: CLLocationCoordinate2D(latitude: stop["lat"] as! Double, longitude:stop["lng"] as! Double),
                            nextBusTimes: nextBusTimes
                        )
                        
                        stops.append(b)
                        }
                        else {
                            let b = Stop(title: stop["name"] as! String,
                                id:stop["id"] as! Int,
                                coordinate: CLLocationCoordinate2D(latitude: stop["lat"] as! Double, longitude:stop["lng"] as! Double),
                                nextBusTimes: ["1":[-1,-2],"2":[-1,-2],"3":[-1,-2],"4":[-1,-2],"5":[-1,-2],"6":[-1,-2],"7":[-1,-2],"8":[-1,-2],"9":[-1,-2]]
                            )
                            stops.append(b)
                            
                        }
                    }
                    
                    else {
                       
                        let b = Stop(title: stop["name"] as! String,
                            id:stop["id"] as! Int,
                            coordinate: CLLocationCoordinate2D(latitude: stop["lat"] as! Double, longitude:stop["lng"] as! Double),
                            nextBusTimes: ["1":[-1,-2],"2":[-1,-2],"3":[-1,-2],"4":[-1,-2],"5":[-1,-2],"6":[-1,-2],"7":[-1,-2],"8":[-1,-2],"9":[-1,-2]]
                        )
                        stops.append(b)
                        
                    }
                    
                }
                APIManager.sharedInstance.setStops(stops)
                
                dispatch_async(dispatch_get_main_queue()) {
                    if let view = view as? OptionsViewController {
                        view.showButtons()
                    }
                    if let view = view as? ViewController {
                        callback?()
                    }
                }
            
        }
        
        catch _ {print("ye")}
        
        
        
    }
    task.resume()
    return stops
    
}


