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
    @IBOutlet weak var athensButton: UIButton!
    var buttons = [UIButton]()
    
    @IBOutlet weak var buffBusInfo: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func scanButton (sender: UIButton!) {
        performSegueWithIdentifier("ViewController", sender: self)
    }
    
    override func viewDidLoad() {
        buttons = [buffButton,hopCButton,hopCCButton,lnbButton,lnsButton,lngButton,athensButton]
        
        spinner.startAnimating()
        for button in buttons {
            button.hidden = true
        }
        super.viewDidLoad()
        
        
        
        hopCButton.tag = 6
        hopCCButton.tag = 7
        buffButton.tag = 1
        lnbButton.tag = 4
        lnsButton.tag = 5
        lngButton.tag = 3
        athensButton.tag = 9
        
        for button in buttons {
            button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        }
        
        buffBusInfo.addTarget(self, action: "infoClicked:", forControlEvents: .TouchUpInside)
        
        
        getRoutes()
        getStops(self)
        getBuses()
    }
    
    func buttonClicked( sender: AnyObject?) {
        
        if sender!.tag != nil {
        routeNumber = sender!.tag
        }else {
        println("The sender tag was nil")
        }
        
        performSegueWithIdentifier("mainSegue", sender: self)
        
    }
    
    func showButtons() {
        spinner.hidden = true
        for button in buttons {
            button.hidden = false
        }
    }
    func infoClicked(sender: AnyObject?) {
        var viewToPresent = RoutePopUpViewController()
        self.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(viewToPresent, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainSegue" {
            if let destination = segue.destinationViewController as? ViewController {
                destination.routeNumber = routeNumber
            }
        }
    }
}
