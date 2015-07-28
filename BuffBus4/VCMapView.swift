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
        
        if annotation is MKUserLocation {
            return nil;
        }
        
      
            
//            var loc1 = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
//            var loc2 = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
//            
//            
//            let distance = loc1.distanceFromLocation(loc2)
//            println(distance)
            
            let identifier = "test"
            var view: MKAnnotationView

                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
      
        var isBus = false
        for bus in buses {
            if bus.title == annotation.title! {
                view.image = UIImage(named: "bus.jpg")
                isBus = true
            }
        }
        
        
        if isBus == false {
        view.image = UIImage(named: "nikcy.jpg")
        }

                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
        
            return view
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        initialLocation = locations[0] as! CLLocation
        if first == 0 {
            centerMapOnLocation(initialLocation)
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