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
        switch routeNumber {
        case 1:
            infoText.text = "The Buff Bus (Brown Line) runs from Williams Village and Bear Creek to campus and has multiple stops around campus. The Buff Bus is free to ride and does not require a bus pass. "
        case 6:
            infoText.text = "The Hop Clockwise route runs in a clockwise direction around central boulder from 10 am to 10pm 7 days a week."
        case 7:
            infoText.text = "The Hop Counterclockwise route runs in a counter-clockwise direction around central boulder from 10 am to 10pm 7 days a week."
        
        case 5:
            infoText.text = "The Late Night Silver route runs down broadway on Thursday Friday Saturday and Sunday from 8pm to 2am. Very similar to Late Night Black"
        case 9:
            infoText.text = "The athens route services?"
        case 4:
            infoText.text = "The Late Night Black route runs down broadway on Thursday Friday Saturday and Sunday from 8pm to 2am. Very similar to the Late Night Silver"
        case 3:
            infoText.text = "The Late night gold route services from the hill to pearl street on Thursday Friday Saturday and Sunday"
        default:
            println("NOPE")
        }
    }
    

    
   
}
