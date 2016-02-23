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
    var routeNumber = ""

    @IBOutlet weak var buffButton: UIButton!
    @IBOutlet weak var hopCButton: UIButton!
    @IBOutlet weak var hopCCButton: UIButton!
    @IBOutlet weak var lnbButton: UIButton!
    @IBOutlet weak var lnsButton: UIButton!
    @IBOutlet weak var lngButton: UIButton!
    @IBOutlet weak var athensButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var feedbackButton: UIButton!
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
        self.scrollView.contentSize = CGSizeMake(300,1060)
        let bounds = self.view.bounds;
        let label = UILabel(frame: CGRectMake(0, 0, 300, 50))
        label.center = CGPointMake(CGRectGetMidX(bounds), 10);

        label.textAlignment = NSTextAlignment.Center
        label.text = "Boulder Bus Tracker"
        label.font = UIFont.systemFontOfSize(27,weight:400)
        self.scrollView.addSubview(label)

        
        
        
        
//        buttons = [buffButton,hopCButton,hopCCButton,lnbButton,lnsButton,lngButton,athensButton,discovExpress]
//        infoButtons = [hopCInfo,hopCCInfo,lnbInfo,lnsInfo,lngInfo,athensInfo,buffBusInfo]
//        feedbackButton.addTarget(self, action: "feedbackEmail:", forControlEvents: .TouchUpInside)

        
        
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
        
        
        
//        hopCButton.tag = 6
//        hopCCButton.tag = 7
//        buffButton.tag = 1
//        lnbButton.tag = 4
//        lnsButton.tag = 5
//        lngButton.tag = 3
//        athensButton.tag = 9
//        discovExpress.tag = 11
        
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
        self.routeNumber = sender!.titleLabel!!.text!
        performSegueWithIdentifier("mainSegue", sender: self)
        
    }
    
    func infoButtonClicked( sender: AnyObject?) {
        if sender!.tag != nil {

        }else {
            print("The sender tag was nil")
        }
        
        performSegueWithIdentifier("goToInfo", sender: self)
        
    }
    
    func showButtons() {
        sleep(2)
        let routes = APIManager.sharedInstance.getRoutes();
        var height = CGFloat(100.0)
        for route in routes {
            if ["Will Vill Football","Football Extension","Will Vill Basketball"].contains(route.name) {
                
            }
            else {
                let button  = UIButton(type: UIButtonType.System) as UIButton
                let bounds = self.view.bounds
                button.frame = CGRectMake(0, height, bounds.width, 50)
                
                button.center = CGPointMake(CGRectGetMidX(bounds), height);
                height = height+53
//                button.tag = route.id
                button.backgroundColor = UIColor.blackColor()
                button.setTitleColor(UIColor(colorLiteralRed: 1.00, green: 0.975, blue: 0.616, alpha: 1.0), forState: UIControlState.Normal)
                
                button.setTitle(route.name, forState: UIControlState.Normal)
                button.titleLabel!.font =  UIFont.systemFontOfSize(25,weight:300)
                button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
                
                self.scrollView.addSubview(button)
                buttons.append(button)
            }
        }
        
        spinner.hidden = true
        for button in buttons {
            button.hidden = false
        }
        for button in infoButtons {
            button.hidden = false
        }
    }
   
            func getRandomColor() -> UIColor{
            let randomRed:CGFloat = CGFloat(drand48())
                let randomGreen:CGFloat = CGFloat(drand48())
                let randomBlue:CGFloat = CGFloat(drand48())
                return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
            }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainSegue" {
            if let destination = segue.destinationViewController as? ViewController {
                destination.routeNumber = sender!.routeNumber
            }
        }
    }
}
