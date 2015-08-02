//
//  VCMapView.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/13/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation

extension ViewController: MKMapViewDelegate {
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var view : MKAnnotationView?
        if annotation is MKUserLocation {
            return nil;
        }
        
        var isBus = false
        for bus in buses {
            if bus.title == annotation.title! {
                view = mapView.dequeueReusableAnnotationViewWithIdentifier("bus")
                isBus = true
            }
        }
        if isBus == false {
            view = mapView.dequeueReusableAnnotationViewWithIdentifier("stop")
        }
        
        
        if view == nil {
            
            var isBus = false
            for bus in buses {
                if bus.title == annotation.title! {
                    view = MKAnnotationView(annotation: annotation, reuseIdentifier: "bus")
                    view!.image = UIImage(named: "busicon.png")
                    isBus = true
                }
            }
            if isBus == false {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: "stop")
                view!.image = UIImage(named: "stop2.png")
            }
            view!.canShowCallout = true
            view!.calloutOffset = CGPoint(x: -5, y: 5)
            view!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
        }
        
        else {
            view!.annotation = annotation
        }
        
        return view
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        initialLocation = locations[0] as! CLLocation
        
        if first == 0 {
            closestStop = ("",10000000.00)
            var i = 0
            for stop in stopinfo  {
                if contains(testRoute.stops,stop.id) {
                    
                    var loc2 = CLLocation(latitude: stop.coordinate.latitude, longitude: stop.coordinate.longitude)
                    
                    let distance = initialLocation.distanceFromLocation(loc2)
                    
                    if closestStop?.Distance > Float(distance){
                        pickerStartingLocation = i
                        closestStop = (stop.title,Float(distance))
                    }
                    
                    i = i + 1
                    
                }
            }
            centerMapOnLocation(initialLocation)
            UIPicker.selectRow(pickerStartingLocation!, inComponent: 0, animated: false)
            // should create helper function so dont have copy of this in 2 places
            if stopDict[stops[pickerStartingLocation]]!.nextBusTimes[0] == 0 {
                timeLabel.text = "Less than a minute"
            }
            else if stopDict[stops[pickerStartingLocation]]!.nextBusTimes[0] < 0 {
                timeLabel.text = "No Buses Currently Running"
                next.hidden = true
            }
            else {
                timeLabel.text = String(stopDict[stops[pickerStartingLocation]]!.nextBusTimes[0]) + " Minutes"
            }
            if stopDict[stops[pickerStartingLocation]]!.nextBusTimes[1] == 0 {
                timeLabel2.text = "Less than a minute"
            }
            else if stopDict[stops[pickerStartingLocation]]!.nextBusTimes[1] < 0 {
                timeLabel2.text = ""
            }
            else {
                timeLabel2.text = String(stopDict[stops[pickerStartingLocation]]!.nextBusTimes[1]) + " Minutes"
            }
//            UIPicker.pickerView(pickerView: UIPicker, didSelectRow: pickerStartingLocation , inComponent: 0)
            first = first+1
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay.isKindOfClass(MKPolyline) {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blueColor()
            polyLineRenderer.lineWidth = 5.0
            
            return polyLineRenderer
        }
        
        return nil
    }
}