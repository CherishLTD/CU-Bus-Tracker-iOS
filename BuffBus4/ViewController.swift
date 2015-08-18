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
    
    @IBOutlet weak var routeLabel: UILabel!
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
    
    var TitleToIndex = [String: Int]()
    
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
        var i = 0
        for stop in stopinfo  {
            if contains(testRoute.stops,stop.id) {
                stopDict[stop.title] = stop
                stops.append(stop.title)
                TitleToIndex[stop.title] = i
                i+=1
            }
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        

        plotNewBuses()
        plotStops()
        

        getInfoTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("plotNewBuses"), userInfo: nil, repeats: true)

        switch routeNumber {
        case 1:
            routeLabel.text = "Buff Bus"
            addRoute(BuffBus)
        case 6:
            routeLabel.text = "HOP Clockwise"
            addRoute(hopClockwise)
        case 7:
            routeLabel.text = "HOP Counterclockwise"
            addRoute(hopCounterClockwise)
        case 3:
            routeLabel.text = "Late Night Gold"
            addRoute(latenightGold)
        case 4:
            routeLabel.text = "Late Night Black"
            addRoute(lateNightBlack)
        case 5:
            routeLabel.text = "Late Night Silver"
            addRoute(latenightSilver)
        case 9:
            routeLabel.text = "Athens Route"
            addRoute(athensRoute)
        case 8:
            routeLabel.text = "Buff Bus Basketball"
            addRoute(basketballRoute)
        case 2:
            routeLabel.text = "Buff Bus Football"
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
            }
            if let closestStopTitle = closestStopTitle as String! {
                if stop.title == closestStopTitle {
                    stop.setNewSubtitle("Nearest Stop")
                }
            }
        }
        if currentPickerLocation != nil  {
            updateTimes(currentPickerLocation!)

        }
      
    }
    
    
    func plotNewBuses() {
        getStops(self,updateStops)
        
        getBuses()
        
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation && !contains(self.stops,$0.title) }
        mapView.removeAnnotations(annotationsToRemove)
        var buses = APIManager.sharedInstance.getBuses()
        for bus in buses {
            if bus.routeID == testRoute.id {
                mapView.addAnnotation(bus)
            }
            
        }
    }
    
    func plotStops() {
        
        for stop in APIManager.sharedInstance.getStops() {
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
    
    override func viewDidDisappear(animated: Bool) {
        closestStopTitle = nil
        getInfoTimer.invalidate()
        
    }
    
    func updateTimes(row: Int) {
        currentPickerLocation = row
        if let times = stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)] {
        
        if stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![0] == 0 {
            timeLabel.text = "No Buses Currently Running"
            next.hidden = true
        }
        
        if  stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![0] == 0 {
            timeLabel.text = "Less than a minute"
            next.hidden = false
        }
        if stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![0] < 0 {
            timeLabel.text = "No Buses Currently Running"
            next.hidden = true
        }
        else {
            next.hidden = false
            var test = stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![0]
            timeLabel.text = String(test) + " Minutes"
        }
        // If only one bus is running/ there is only one next time in the array
        // It will break from the index being out of range
        if stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]!.count > 1 {
            if stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![1] == 0 {
                timeLabel2.text = "Less than a minute"
                
            }
            if stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![1] < 0 {
                timeLabel2.text = ""
               
                
            }
            else {
                var test = stopDict[stops[row]]!.nextBusTimes[String(testRoute.id)]![1]
                timeLabel2.text = String(test) + " Minutes"
               
            }
        } else {
            timeLabel2.text = ""
        }
        }
        else {
            timeLabel.text = "No Buses Currently Running"
            timeLabel2.text = ""
            next.hidden = true
        }
        
    }
}

