//
//  GMLight.swift
//  lumen
//
//  Created by Gregg Mojica on 10/7/15.
//  Copyright © 2015 Gregg Mojica. All rights reserved.
//

import UIKit

class GMLight: NSObject {

    func turnOffLights() {
        for i in 0..<12 {
            bulbOn(i, bulbState: "false")//(i, bulbState: "false", isError: false)
        }
    }
    
    func bulbOn(bulbNumber: Int, bulbState: String) {
        
        
            // There is an ERROR
            
            //            let randomNumber = 50000
            let url = NSURL(string: "\(varialbles.IP)\(bulbNumber)/state")
            
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "PUT"
            
            let dataString = "{\"on\":\(bulbState), \"hue\":\(25500), \"sat\":255, \"bri\":255}"
            let data = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            
            request.HTTPBody = data
            let connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
            
            //            print("sending request...")
            
            connection!.start()
        }
        
        
    
}
