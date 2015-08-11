//
//  VCPickerView.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import UIKit
import MapKit


extension ViewController {    
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
        updateTimes(row)
        
        for annotation1 in mapView.annotations {
            if annotation1.title == stops[row] {
                let annotation1 = annotation1 as? MKAnnotation
                mapView.selectAnnotation(annotation1, animated:true)
            }
        
        }
    }
    
}