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
    hopCButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
    }
    
   func buttonClicked(_ sender: AnyObject?) {
    print("Hello world")
    //presentViewController(ViewController(), animated: true, completion: nil)
    performSegueWithIdentifier("mainSegue", sender: nil)

    }
}
