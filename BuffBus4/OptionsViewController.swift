//
//  OptionsViewController.swift
//  BuffBus4
//
//  Created by Nicholas Smith on 7/18/15.
//  Copyright (c) 2015 Joshua Ferge. All rights reserved.
//

import Foundation
import UIKit


class OptionsViewController: UIViewController {
    var routeNumber: Int!

    @IBOutlet weak var buffButton: UIButton!
    @IBOutlet weak var hopCButton: UIButton!
    @IBOutlet weak var hopCCButton: UIButton!
    @IBOutlet weak var lnbButton: UIButton!
    @IBOutlet weak var lnsButton: UIButton!
    @IBOutlet weak var lngButton: UIButton!
    
    @IBAction func scanButton (sender: UIButton!) {
        performSegueWithIdentifier("ViewController", sender: self)
    }
    
    override func viewDidLoad() {
        hopCButton.tag = 6
        hopCButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        hopCCButton.tag = 7
        hopCCButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        buffButton.tag = 1
        buffButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        lnbButton.tag = 4
        lnbButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        lnsButton.tag = 5
        lnsButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        lngButton.tag = 3
        lngButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        
    }
    
    
    func buttonClicked( sender: AnyObject?) {

        switch sender!.tag {
        case 1:
            routeNumber = 1
        case 6:
            routeNumber = 6
        case 7:
            routeNumber = 7
        case 4:
            routeNumber = 4
        case 5:
            routeNumber = 5
        case 3:
            routeNumber = 3
        default:
            fatalError("The route numbers didn't match")
        }
        performSegueWithIdentifier("mainSegue", sender: self)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let identifier = segue.identifier as String!

        if segue.identifier == "mainSegue" {
            if let destination = segue.destinationViewController as? ViewController {
                println("FUCK")
                destination.routeNumber = routeNumber
            }
        }
    }
}
