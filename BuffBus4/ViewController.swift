//
//  ViewController.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/11/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
//    var stops = ["Bear Creek","Williams Village", "Engineering Center", "Duane", "C4C", "UMC","Math Building"]
    
    var stopDict = [String: Stop]()
    var stops = [String]()
    
    
    var initialLocation = CLLocation(latitude: 40.00373423, longitude: -105.2339187)
    var first = 0
    override func viewDidLoad() {
        
        var stopinfo = getStops()
        
        for stop in stopinfo  {
            if stop.nextBusTimes.count > 1 {
            stopDict[stop.title] = stop
            stops.append(stop.title)
            }
        }
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        centerMapOnLocation(initialLocation)
        
        let url = NSURL(string: "http://www.stackoverflow.com")
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//        }
        
//        task.resume()
        
        
        var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("getInfo"), userInfo: nil, repeats: true)

        

        
    }

    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 5.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    func plotBusses(Busses: [AnyObject]) {
        
    }
    
    func getInfo()
    {
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove)
        var busses = getBusses()
        for bus in busses {
            if bus.nextStopID > 0 {
                mapView.addAnnotation(bus)
            }
            
        }
        var stops2 = getStops()
        for stop in stops2 {
            if stop.nextBusTimes.count > 1 {
                mapView.addAnnotation(stop)
            }
        }
    }
    
    
   
 
    
}

