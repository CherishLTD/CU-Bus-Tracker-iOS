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
    @IBOutlet weak var next: UILabel!
    
    var stopDict = [String: Stop]()
    var stops = [String]()
    var stopinfo = APIManager.sharedInstance.getStops()
    var closestStop: ( Name:String, Distance: Float)?
    var pickerStartingLocation : Int!
    
    var closestStopTitle : String?
    
    
    var currentPickerLocation : Int?
    var getInfoTimer : NSTimer!
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
        

        getInfoTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("plotNewBuses"), userInfo: nil, repeats: true)

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
        case 9:
            addRoute(athensRoute)
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
    
    func updateStops() {
        var stopinfo = APIManager.sharedInstance.getStops()
        for stop in stopinfo  {
            if contains(testRoute.stops,stop.id) {
                stopDict[stop.title] = stop
                stops.append(stop.title)
            }
            if stop == closestStopTitle {
                stop.setNewSubtitle("Nearest Stop")
            }
        }
        if currentPickerLocation != nil  {
            if stopDict[stops[currentPickerLocation!]]!.nextBusTimes[0] == 0 {
                timeLabel.text = "Less than a minute"
            }
            else if stopDict[stops[currentPickerLocation!]]!.nextBusTimes[0] < 0 {
                timeLabel.text = "No Buses Currently Running"
            }
            else {
                timeLabel.text = String(stopDict[stops[currentPickerLocation!]]!.nextBusTimes[0]) + " Minutes"
            }
            // If only one bus is running/ there is only one next time in the array
            // It will break from the index being out of range
            
            if stopDict[stops[currentPickerLocation!]]!.nextBusTimes[1] == 0 {
                timeLabel2.text = "Less than a minute"
            }
            else if stopDict[stops[currentPickerLocation!]]!.nextBusTimes[1] < 0 {
                timeLabel2.text = ""
            }
            else {
                timeLabel2.text = String(stopDict[stops[currentPickerLocation!]]!.nextBusTimes[1]) + " Minutes"
            }

        }
        else {
            println(":(")
        }
    }
    
    
    func plotNewBuses() {
        getStops(self,updateStops)
        getBuses()
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove)
        var buses = APIManager.sharedInstance.getBuses()
        for bus in buses {
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
//        stopinfo = APIManager.sharedInstance.getStops()
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
    
    override func viewDidDisappear(animated: Bool) {
        closestStopTitle = nil
        getInfoTimer.invalidate()
        
    }
}

