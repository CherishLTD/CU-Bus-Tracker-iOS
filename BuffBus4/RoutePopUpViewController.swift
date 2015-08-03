//
//  RoutePopUpViewController.swift
//  BuffBus4
//
//  Created by jferge on 8/2/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import UIKit

class RoutePopUpViewController: UIViewController {
    var routeNumber : Int!
    
    @IBOutlet weak var infoText: UITextView!
    override func viewDidLoad() {
        println(routeNumber)
        switch routeNumber {
        case 1:
            infoText.text = "TEST"
        case 5:
            infoText.text = "TEST"
        default:
            println("NOPE")
        }
    }
    
    
   
}
