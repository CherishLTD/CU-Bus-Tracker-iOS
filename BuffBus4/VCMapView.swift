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
        
        
        if let annotation = annotation as? MKAnnotation  {
            
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
                var image: UIImage? = UIImage(named: "nikcy.jpg")
                if image != nil {
                    //println("yay")
                }
                
                view.image = UIImage(named: "nikcy.jpg")


                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
        
            return view
        }
        return nil
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        initialLocation = locations[0] as! CLLocation
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
}