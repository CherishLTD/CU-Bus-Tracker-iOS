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
    @IBOutlet weak var stopLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var stops = ["Bear Creek","Williams Village", "Engineering Center", "Duane", "C4C", "UMC","Math Building"]
    var initialLocation = CLLocation(latitude: 40.00373423, longitude: -105.2339187)
    var first = 0
    override func viewDidLoad() {
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
        
        
        var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("sayHello"), userInfo: nil, repeats: true)

        

        
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stops.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return stops[row]
    }
  
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stopLabel.text = stops[row]
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        initialLocation = locations[0] as! CLLocation
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 5.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    func plotBusses(Busses: [AnyObject]) {
        
    }
    
    func sayHello()
    {
        let annotationsToRemove = mapView.annotations.filter { $0 !== self.mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove)
        var busses = getBusses()
        for bus in busses {
            if bus.nextStopID > 0 {
                mapView.addAnnotation(bus)
            }
        }
    }
    
    
   
 
    
}

