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
    
    @IBOutlet weak var UIPicker: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel2: UILabel!
    
    var stopDict = [String: Stop]()
    var stops = [String]()
    var routes = getRoutes()
    var testRoute : Route!
    var routeNumber = 0
    var buses = getBuses()
    
    
    var initialLocation = CLLocation(latitude: 40.00373423, longitude: -105.2339187)
    var first = 0
    override func viewDidLoad() {

        mapView.delegate = self
        
        super.viewDidLoad()
        
        for route in routes {
            if route.id == routeNumber {
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
        
        
        plotNewBuses()

        var getInfoTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("plotNewBuses"), userInfo: nil, repeats: true)
        
        
        addRoute()
       
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIPicker.selectRow(5, inComponent: 0, animated: true)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    
    func plotNewBuses()
    {
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove)
        var busses = getBuses()
        for bus in busses {
            if bus.nextStopID > 0 && bus.routeID == testRoute.id {
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
  

    
    func addRoute() {
        
        


//        let thePath = NSBundle.mainBundle().pathForResource("Route1", ofType: "plist")
        
        let pointsCount = pointsArray.count
        
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for i in 0...pointsCount-1 {
            
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(pointsArray[i][1]), CLLocationDegrees(pointsArray[i][0]))]
        }
        
        let myPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        mapView.addOverlay(myPolyline)
        

    }
}

