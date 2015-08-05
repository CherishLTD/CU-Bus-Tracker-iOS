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
            if annotation.title != closestStopTitle {
                view = mapView.dequeueReusableAnnotationViewWithIdentifier("stop")
            }
            else {
                if annotation.subtitle != "" {
                view = mapView.dequeueReusableAnnotationViewWithIdentifier("closestStop")
                }
            }
        }
        
        if view == nil {
            
            var isBus = false
            for bus in buses {
                
                if bus.title == annotation.title! && bus.title != closestStopTitle {
                    view = MKAnnotationView(annotation: annotation, reuseIdentifier: "bus")
                    view!.image = UIImage(named: "busicon.png")
                    isBus = true

                }
            }
            if isBus == false {
                if annotation.title != closestStopTitle {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: "stop")
                view!.image = UIImage(named: "gold_BlackBorder.png")
                view!.centerOffset = CGPointMake(5, -5);
                view!.calloutOffset = CGPoint(x: -5, y: 20)
                }
                else {
                    if annotation.title == closestStopTitle {
                    
                        view = MKAnnotationView(annotation: annotation, reuseIdentifier: "closestStop")
                        view!.image = UIImage(named: "red+gold.png")
                        view!.centerOffset = CGPointMake(5, -5);
                        view!.calloutOffset = CGPoint(x: 0, y: 15)
                    }
                }
            }
            view!.canShowCallout = true
          
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
                        closestStopTitle = stop.title
                        pickerStartingLocation = i
                        closestStop = (stop.title,Float(distance))
                    }
                    
                    i = i + 1
                    
                }
                
            }
            
            for stop in stopinfo {
                if stop.title == closestStopTitle! {
                    stop.setNewSubtitle("Nearest Stop")
                    var annotationsRemove = mapView.annotations.filter { $0.title == self.closestStopTitle  }
                    mapView.removeAnnotations( annotationsRemove)
                    mapView.addAnnotation(stop)
                }
            }
            
            centerMapOnLocation(initialLocation)

            
            UIPicker.selectRow(pickerStartingLocation!, inComponent: 0, animated: false)
            
            currentPickerLocation = pickerStartingLocation!
            updateTimes(currentPickerLocation!)
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
            polyLineRenderer.strokeColor = UIColor.blackColor()
            polyLineRenderer.lineWidth = 3.0
            
            return polyLineRenderer
        }
        
        return nil
    }
}