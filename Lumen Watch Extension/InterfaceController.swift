//
//  InterfaceController.swift
//  Lumen Watch Extension
//
//  Created by Eric Amodeo on 4/20/16.
//  Copyright © 2016 Gregg Mojica. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var IP = "http://10.0.1.11/api/585df0b2742956f4fe201321d5a2f7/lights/"
    @IBOutlet var leftButton: WKInterfaceButton!
    @IBOutlet var rightButton: WKInterfaceButton!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    @IBAction func didClickLeftButton() {
        
        
    }
    @IBAction func didClickRightButton() {
    }
    @IBAction func bulbOnOff() {
        
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
