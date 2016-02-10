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
    var routeNumber = 1

    @IBOutlet weak var buffButton: UIButton!
    @IBOutlet weak var hopCButton: UIButton!
    @IBOutlet weak var hopCCButton: UIButton!
    @IBOutlet weak var lnbButton: UIButton!
    @IBOutlet weak var lnsButton: UIButton!
    @IBOutlet weak var lngButton: UIButton!
    @IBOutlet weak var athensButton: UIButton!
    
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var discovExpress: UIButton!
    
    @IBOutlet weak var buffBusInfo: UIButton!
    @IBOutlet weak var hopCInfo: UIButton!
    @IBOutlet weak var hopCCInfo: UIButton!
    @IBOutlet weak var athensInfo: UIButton!
    @IBOutlet weak var lnbInfo: UIButton!
    @IBOutlet weak var lnsInfo: UIButton!
    @IBOutlet weak var lngInfo: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBAction func scanButton (sender: UIButton!) {
        performSegueWithIdentifier("ViewController", sender: self)
    }
    
    
    
    var buttons = [UIButton]()
    
    var infoButtons = [UIButton]()
    
    override func viewDidLoad() {
        buttons = [buffButton,hopCButton,hopCCButton,lnbButton,lnsButton,lngButton,athensButton,discovExpress]
//        infoButtons = [hopCInfo,hopCCInfo,lnbInfo,lnsInfo,lngInfo,athensInfo,buffBusInfo]
        feedbackButton.addTarget(self, action: "feedbackEmail:", forControlEvents: .TouchUpInside)

        
        
        if APIManager.sharedInstance.getStops() == nil {
            for button in buttons {
                button.hidden = true
            }
            for button in infoButtons {
                button.hidden = true
            }
            
            spinner.startAnimating()
            getRoutes()
            getStops(self,callback: nil)
        }
        else {
            spinner.stopAnimating()
            self.showButtons()
        }
        
        
        getBuses()
        
        
        super.viewDidLoad()
        
        
        
        hopCButton.tag = 6
        hopCCButton.tag = 7
        buffButton.tag = 1
        lnbButton.tag = 4
        lnsButton.tag = 5
        lngButton.tag = 3
        athensButton.tag = 9
        discovExpress.tag = 11
        
//        hopCInfo.tag = 6
//        hopCCInfo.tag = 7
//        buffBusInfo.tag = 1
//        lnbInfo.tag = 4
//        lnsInfo.tag = 5
//        lngInfo.tag = 3
//        athensInfo.tag = 9
        
        for button in buttons {
            button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        }
        
//        for button in infoButtons {
//            button.addTarget(self, action: "infoButtonClicked:", forControlEvents: .TouchUpInside)
//        }

        
    }
    
    func feedbackEmail( sender: AnyObject?) {
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:cherishdevapps@gmail.com")!)
    }
    
    func buttonClicked( sender: AnyObject?) {
        
        if sender!.tag != nil && sender!.tag != 1 {
            routeNumber = sender!.tag
        }
        
        else if sender!.tag == 1 {
            var isThereABuffBus = false
            for bus in APIManager.sharedInstance.getBuses() {
                if bus.routeID == 1 {
                    isThereABuffBus = true
                }
                
            }
            if !isThereABuffBus {
                var isThereABuffBusFootball = false
                for bus in APIManager.sharedInstance.getBuses() {
                    if bus.routeID == 2 {
                        isThereABuffBusFootball = true
                    }
                }
                if isThereABuffBusFootball {
                    routeNumber = 2
                }
                
                else {
                    var isThereABuffBusBasketball = false
                    for bus in APIManager.sharedInstance.getBuses() {
                        if bus.routeID == 8 {
                            isThereABuffBusBasketball = true
                        }
                    }
                    if isThereABuffBusBasketball {
                        routeNumber = 8
                    }
                    else {
                        routeNumber = 1
                    }
                    
                }
            }
            else {
                routeNumber = 1
            }
            
        }
        
        else {
            print("The sender tag was nil")
        }
        
        performSegueWithIdentifier("mainSegue", sender: self)
        
    }
    
    func infoButtonClicked( sender: AnyObject?) {
        if sender!.tag != nil {
            routeNumber = sender!.tag
        }else {
            print("The sender tag was nil")
        }
        
        performSegueWithIdentifier("goToInfo", sender: self)
        
    }
    
    func showButtons() {
        spinner.hidden = true
        for button in buttons {
            button.hidden = false
        }
        for button in infoButtons {
            button.hidden = false
        }
    }
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainSegue" {
            if let destination = segue.destinationViewController as? ViewController {
                destination.routeNumber = routeNumber
            }
        }
        
        if segue.identifier == "goToInfo" {
            if let destination = segue.destinationViewController as? RoutePopUpViewController {
                destination.routeNumber = routeNumber
            }
        }
    }
}
