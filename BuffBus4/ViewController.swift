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

    var stopDict = [String: Stop]()
    var stops = [String]()
    var routes = getRoutes()
    var testRoute : Route!
    
    
    
    
    var initialLocation = CLLocation(latitude: 40.00373423, longitude: -105.2339187)
    var first = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("hi")
        for route in routes {
            if route.id == 7 {
                testRoute = route
                
            }
        }
        
        var stopinfo = getStops()
        
        for stop in stopinfo  {
            if contains(testRoute.stops,stop.id) {
                stopDict[stop.title] = stop
                stops.append(stop.title)
            }
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        centerMapOnLocation(initialLocation)
        
        let url = NSURL(string: "http://www.stackoverflow.com")
        
        plotNewBuses()
        var getInfoTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("plotNewBuses"), userInfo: nil, repeats: true)
        
    }

    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 5.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    
    func plotNewBuses()
    {
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove)
        var busses = getBuses()
        for bus in busses {
            if bus.nextStopID > 0 && bus.routeID == testRoute {
                mapView.addAnnotation(bus)
            }
            
        }
        var stops2 = getStops()
        for stop in stops2 {
            if contains(testRoute.stops,stop.id) {
                mapView.addAnnotation(stop)
            }
        }
    }
}

