//
//  WelcomeViewController.swift
//  Lumen
//
//  Created by Gregg Mojica on 9/16/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

import UIKit

enum appMode: String {
    case practice = "Practice"
    case visualize = "Visualize"
    case game = "Game"
}

class WelcomeViewController: UIViewController {
    var type: String?
    
    @IBOutlet var practice: UIButton!
    @IBOutlet var visualize: UIButton!
    @IBOutlet var game: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = ViewController()
        
        for i in 1..<11 {
            vc.didRequestBulbChange(i, bulbState: "true", isError: false)
        }

        
        
        self.practice.backgroundColor = UIColor.clearColor()
        self.practice.layer.cornerRadius = 5
        self.practice.layer.borderWidth = 1
        self.practice.layer.borderColor = UIColor.blackColor().CGColor
        
        self.visualize.backgroundColor = UIColor.clearColor()
        self.visualize.layer.cornerRadius = 5
        self.visualize.layer.borderWidth = 1
        self.visualize.layer.borderColor = UIColor.blackColor().CGColor
        
        self.game.backgroundColor = UIColor.clearColor()
        self.game.layer.cornerRadius = 5
        self.game.layer.borderWidth = 1
        self.game.layer.borderColor = UIColor.blackColor().CGColor
        
        
        // Do any additional setup after loading the view.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showMode") {
            let viewController:ViewController = segue.destinationViewController as! ViewController
            viewController.type = self.type
        }
    }
    
    @IBAction func practiceButton(sender: AnyObject) {
       self.type = appMode.practice.rawValue
        self.performSegueWithIdentifier("showMode", sender: self)
    }
    
    @IBAction func visualize(sender: AnyObject) {
        self.type = appMode.visualize.rawValue
        self.performSegueWithIdentifier("showMode", sender: self)


    }
    
    @IBAction func game(sender: AnyObject) {
        self.type = appMode.game.rawValue
        self.performSegueWithIdentifier("showMode", sender: self)


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
