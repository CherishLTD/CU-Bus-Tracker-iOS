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
    var stopinfo = APIManager.sharedInstance.getStops()
    var closestStop: ( Name:String, Distance: Float)?
    var pickerStartingLocation : Int!
    
    var routes = APIManager.sharedInstance.getRoutes()
    var testRoute : Route!
    var routeNumber = 0
    
    var buses = APIManager.sharedInstance.getBuses()
    
    var initialLocation : CLLocation!
    var first = 0
    
    override func viewDidLoad() {
        mapView.delegate = self
        mapView.showsPointsOfInterest = false
        super.viewDidLoad()
        
        for route in routes {
            if route.id == routeNumber {
                testRoute = route
            }
        }
        
        for stop in stopinfo  {
            if contains(testRoute.stops,stop.id) {
                stopDict[stop.title] = stop
                stops.append(stop.title)
            }
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
            
        plotNewBuses()

        var getInfoTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("plotNewBuses"), userInfo: nil, repeats: true)
        
        switch routeNumber {
        case 1:
            addRoute(BuffBus)
        case 6:
            addRoute(hopClockwise)
        case 7:
            addRoute(hopCounterClockwise)
        case 3:
            addRoute(latenightGold)
        case 4:
            addRoute(lateNightBlack)
        case 5:
            addRoute(latenightSilver)
        case 8:
            addRoute(basketballRoute)
        case 2:
            addRoute(footballRoute)
        default:
            println("error")
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    
    func plotNewBuses() {
        getBuses()
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove)
        var busses = APIManager.sharedInstance.getBuses()
        for bus in busses {
            if bus.nextStopID > 0 && bus.routeID == testRoute.id {
                mapView.addAnnotation(bus)
            }
            
        }
        var stops2 = APIManager.sharedInstance.getStops()
        for stop in stops2 {
            if contains(testRoute.stops,stop.id) {
                mapView.addAnnotation(stop)
            }
        }
    }
    
    func addRoute(ptrToArray: [[Float]]) {
        let pointsCount = ptrToArray.count
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for i in 0...pointsCount-1 {
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(ptrToArray[i][1]), CLLocationDegrees(ptrToArray[i][0]))]
        }
        
        let myPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        mapView.addOverlay(myPolyline)
    }
}

