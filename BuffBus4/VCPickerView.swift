//
//  VCPickerView.swift
//  BuffBus4
//
//  Created by Joshua Ferge on 7/17/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import UIKit


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
        if stopDict[stops[row]]!.nextBusTimes[0] == 0 {
            timeLabel.text = "Less than a minute"
        }
        else if stopDict[stops[row]]!.nextBusTimes[0] < 0 {
            timeLabel.text = "No Buses Currently Running"
        }
        else {
            timeLabel.text = String(stopDict[stops[row]]!.nextBusTimes[0]) + " Minutes"
        }
        if stopDict[stops[row]]!.nextBusTimes[1] == 0 {
            timeLabel2.text = "Less than a minute"
        }
        else if stopDict[stops[row]]!.nextBusTimes[1] < 0 {
            timeLabel2.text = ""
        }
        else {
            timeLabel2.text = String(stopDict[stops[row]]!.nextBusTimes[1]) + " Minutes"
        }

    }
    

}