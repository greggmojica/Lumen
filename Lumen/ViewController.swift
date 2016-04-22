//
//  ViewController.swift
//  Lumen
//
//  Created by Gregg Mojica on 9/5/15.
//  Copyright (c) 2015 Gregg Mojica. All rights reserved.
//

import UIKit
import AVFoundation

struct varialbles {
    static var IP = "http://10.0.1.11/api/585df0b2742956f4fe201321d5a2f7/lights/"
}

class ViewController: UIViewController, UIScrollViewDelegate {
    var ding:AVAudioPlayer = AVAudioPlayer()

    var type: String?
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var label128: UILabel!
    @IBOutlet var label64: UILabel!
    @IBOutlet var label32: UILabel!
    @IBOutlet var label16: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label1: UILabel!

    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    
    @IBOutlet var bulb1: UIImageView!
    @IBOutlet var bulb2: UIImageView!
    @IBOutlet var bulb3: UIImageView!
    @IBOutlet var bulb4: UIImageView!
    @IBOutlet var bulb5: UIImageView!
    @IBOutlet var bulb6: UIImageView!
    @IBOutlet var bulb7: UIImageView!
    @IBOutlet var bulb8: UIImageView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var number: UITextField!
    
    @IBOutlet var randomNumberLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var endGame: UIButton!
    @IBOutlet var highScoreLabel: UILabel!
    
    var randomNumber:Int = 0
    var userBinary:Int?
    var correctBinary: String?
    
    var binary1:Int = 0
    var binary2:Int = 0
    var binary3:Int = 0
    var binary4:Int = 0
    var binary5:Int = 0
    var binary6:Int = 0
    var binary7:Int = 0
    var binary8:Int = 0
    
    var bool1:Bool?
    var bool2:Bool?
    var bool3: Bool?
    var bool4: Bool?
    var bool5: Bool?
    var bool6: Bool?
    var bool7: Bool?
    var bool8: Bool?
    
    var bulbOnePressed:Int = 0
    var bulbTwoPressed:Int = 0
    var bulbThreePressed:Int = 0
    var bulbFourPressed:Int = 0
    var bulbFivePressed:Int = 0
    var bulbSixPressed:Int = 0
    var bulbSevenPressed:Int = 0
    var bulbEightPressed:Int = 0
    
    var counter:Int = 0
    
    var gameTimer: NSTimer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        for i in 1..<10 {
            didRequestBulbChange(i, bulbState: "false", isError: false)
        }
        
        scrollView.contentSize = CGSizeMake(190, 790)
        scrollView.delegate = self
        
        self.endGame.hidden = true
        self.highScoreLabel.hidden = true
        self.timeLabel.hidden = true
        
        if (self.type! == "Game") {
            self.endGame.hidden = false
            self.highScoreLabel.hidden = false
            self.timeLabel.hidden = false
            
            let score = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
            self.highScoreLabel.text = "Score: \(score)"
        }
        
        self.gameTimer = NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: Selector("timer"),
            userInfo: nil,
            repeats: true)
    
        self.titleLabel.text = self.type!

        if (self.type! == "Game" || self.type! == "Visualize") {
            let labels = [self.label1, self.label2, self.label4, self.label8, self.label16, self.label32, self.label64, self.label128]
            for label in labels {
                label.hidden = true
            }
        }
        
        if (self.type! == "Game" || self.type! == "Practice"){
            self.randomNumber = createRandomRange(1, upper: 256)
            self.randomNumberLabel.text = "\(self.randomNumber)"
        }
        
        if (self.type! == "Practice" || self.type! == "Game") {
                self.minusButton.hidden = true
                self.plusButton.hidden = true
        }
        
        if (self.type! == "Visualize") {
            self.submitButton.hidden = true
            self.randomNumber = 0
            self.randomNumberLabel.text = "\(self.randomNumber)"

            self.plusButton.backgroundColor = UIColor.clearColor()
            self.plusButton.layer.cornerRadius = 5
            self.plusButton.layer.borderWidth = 1
            self.plusButton.layer.borderColor = UIColor.blackColor().CGColor
            
            self.minusButton.backgroundColor = UIColor.clearColor()
            self.minusButton.layer.cornerRadius = 5
            self.minusButton.layer.borderWidth = 1
            self.minusButton.layer.borderColor = UIColor.blackColor().CGColor
            
        }
       
         // Do any additional setup after loading the view, typically from a nib.
    }
    
    func timer() {
        self.counter++
        self.timeLabel.text = "Time: \(self.counter)"
    }

 
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
        
            resetBulbs(0)
        }
    }
    
    // MARK: Reset Bulbs Function
    func resetBulbs(number:Int) {
    
        let buttons = [self.btn1, self.btn2, self.btn3, self.btn4, self.btn5, self.btn6, self.btn7, self.btn8]
        for button in buttons {
            button.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        }
        
        self.bool1 = false
        self.bulbOnePressed = 0

        self.bool2 = false
        self.bulbTwoPressed = 0

        self.bool3 = false
        self.bulbThreePressed = 0

        self.bool4 = false
        self.bulbFourPressed = 0

        self.bool5 = false
        self.bulbFivePressed = 0

        self.bool6 = false
        self.bulbSevenPressed = 0
        
        self.bool7 = false
        self.bulbSevenPressed = 0
        
        self.bool8 = false
        self.bulbEightPressed = 0
        
        if number == 0 {
            if (self.type! == "Visualize") {
                
            } else {
                self.randomNumber = createRandomRange(1, upper: 256)
            }
            self.randomNumberLabel.text = "\(self.randomNumber)"
        } else {
            self.randomNumber = number
        }
        
        for i in 1..<10 {
            didRequestBulbChange(i, bulbState: "false", isError: false)
            
        }
    }
    
    // MARK: Did Request Bulb Change

    func didRequestBulbChange(bulbNumber: Int, bulbState: String, isError: Bool) {
        print("Is error \(isError)")
        
        if (isError == true) { // There is an error

            let url = NSURL(string: "\(varialbles.IP)\(bulbNumber)/state")
            
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "PUT"
            
            let dataString = "{\"on\":\(bulbState), \"hue\":\(65280), \"sat\":255, \"bri\":255}"
            let data = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            
            request.HTTPBody = data
            let connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
            
            connection!.start()
        }
       
        else {
            let randomNumber = arc4random_uniform(70000) // Differnt Colors
            
            let url = NSURL(string: "\(varialbles.IP)\(bulbNumber)/state")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "PUT"
            
            let dataString = "{\"on\":\(bulbState), \"hue\":\(randomNumber), \"sat\":255, \"bri\":255}"
            let data = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            
            request.HTTPBody = data
            let connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
            
            connection!.start()
        }
    }
    
    
    func successMode(bulbNumber: Int) {
        let randomNumber = arc4random_uniform(70000) // Differnt Colors
        let url = NSURL(string: "\(varialbles.IP)\(bulbNumber)/state")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "PUT"
        
        
        let dataString = "{\"on\":true, \"hue\":\(randomNumber)}"
        
        let data = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = data
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        print("sending request...")
        
        connection!.start()
    }

    
    
    
    func randomNumber(number:Int?) {

        IntToBinary(number!) { (success) -> Void in
            
        }
    }
    
    
    // MARK: Int to Binary Function
    
    func IntToBinary(number:Int, completionHandler:(success:Bool) -> Void) {
    
        completionHandler(success:true)

        let string = String(Int(number), radix: 2)
        print("Number is \(number)")
        let binaryRepresentation = convertBinary(string, size: 8)
        print("Binary is \(binaryRepresentation)")
        
        self.correctBinary = binaryRepresentation
    }
    
    func createRandomRange (lower: Int , upper: Int) -> Int {
        // Return random number between 1 - 256 || Take 256 - 1 + 1 = 255 (do not account for 0 index)  Add 1
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))

    }
    
    
    func convertBinary(string : String, size: Int) -> String {
        var zeros = string
        for i in 0..<size - string.characters.count {
            zeros = "0" + zeros
        }
        return zeros
    }
   
    // Function Output
    
    
    // 1, 2, 4, 8, 16, 32
    
    func findIndex(i:Int, visualizeMode: Bool) -> Int {
        if (i == 0) {
            
//            didRequestBulbChange(1, bulbState: "true", isError: false)
            successMode(1)
            
            
            // Bulb 1 ON
            return 1
        }
        else if (i == 1) {
            // Bulb 2 ON
//            didRequestBulbChange(2, bulbState: "true", isError: false)
            
            successMode(2)

            return 2
        }
        else if (i == 2) {
            // Bulb 4 ON
//            didRequestBulbChange(3, bulbState: "true", isError: false)

            successMode(3)
            

            return 4
        }
        else if (i == 3) {
            // Bulb 8 ON
            successMode(4)
            
            //didRequestBulbChange(4, bulbState: "true", isError: false)


            return 8
        }
        else if (i == 4) {
            // Bulb 16 ON
            successMode(5)
            
            //didRequestBulbChange(5, bulbState: "true", isError: false)

            

            return 16
        }
        else if (i == 5) {
            // Bulb 32 ON
            
            successMode(6)
            
           // didRequestBulbChange(6, bulbState: "true", isError: false)
            
            
            
            return 32
        }
        else if (i == 6) {
            successMode(7)
            
            //didRequestBulbChange(7, bulbState: "true", isError: false)


            return 64
        }
        else if (i == 7) {
            successMode(8)
            
           // didRequestBulbChange(8, bulbState: "true", isError: false)


            return 128
        }
        
        return 2
    }
 
    
    // MARK: IBActions

    @IBAction func button1(sender: AnyObject) {
        
        self.bulbOnePressed++
    
        if self.bulbOnePressed % 2 == 0 {

            self.bool1 = false
            self.btn1.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
            
        } else {
            self.bool1 = true
            self.btn1.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
            
        }
    }
    
    @IBAction func button2(sender: AnyObject) {
        self.bulbTwoPressed++

        if self.bulbTwoPressed % 2 == 0 {

        self.bool2 = false
        self.btn2.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool2 = true
            self.btn2.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
            
        }
    }
    @IBAction func button3(sender: AnyObject) {
        
        self.bulbThreePressed++
        
        if self.bulbThreePressed % 2 == 0 {
            self.bool3 = false
            self.btn3.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool3 = true
            self.btn3.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
        }
       
    }
    @IBAction func button4(sender: AnyObject) {
        
        self.bulbFourPressed++
        
        if self.bulbFourPressed % 2 == 0 {
            self.bool4 = false
            self.btn4.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool4 = true
            self.btn4.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
        }
    
    }
    @IBAction func button5(sender: AnyObject) {
        
        self.bulbFivePressed++
        
        if self.bulbFivePressed % 2 == 0 {
            self.bool5 = false
            self.btn5.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool5 = true
            self.btn5.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
        }
        
    }
    @IBAction func button6(sender: AnyObject) {
        self.bulbSixPressed++
        
        if self.bulbSixPressed % 2 == 0 {
            self.bool6 = false
            self.btn6.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool6 = true
            self.btn6.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
        }
    }
    @IBAction func button7(sender: AnyObject) {
        self.bulbSevenPressed++
        
        if self.bulbSevenPressed % 2 == 0 {
            self.bool7 = false
            self.btn7.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool7 = true
            self.btn7.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
        }
        
    }
    @IBAction func button8(sender: AnyObject) {
        self.bulbEightPressed++
        
        if self.bulbEightPressed % 2 == 0 {
            self.bool8 = false
            self.btn8.setImage(UIImage(named: "bulb"), forState: UIControlState.Normal)
        } else {
            self.bool8 = true
            self.btn8.setImage(UIImage(named: "bulbOn"), forState: UIControlState.Normal)
        }
    }
    

    
    // MARK: Submit Button
    @IBAction func submit(sender: AnyObject) {
        
        randomNumber(self.randomNumber)
        
        if (self.bool1 == true) {
            self.binary1 = 1
        } else {
            self.binary1 = 0
        }
        
        if (self.bool2 == true) {
            self.binary2 = 1
        } else {
            self.binary2 = 0
        }
        
        if (self.bool3 == true) {
            self.binary3 = 1
        } else {
            self.binary3 = 0
        }
        
        if (self.bool4 == true) {
            self.binary4 = 1
        } else {
            self.binary4 = 0
        }
        
        if (self.bool5 == true) {
            self.binary5 = 1
        } else {
            self.binary5 = 0
        }
        
        if (self.bool6 == true) {
            self.binary6 = 1
        } else {
            self.binary6 = 0
        }
        
        if (self.bool7 == true) {
            self.binary7 = 1
        } else {
            self.binary7 = 0
        }
        
        if (self.bool8 == true) {
            self.binary8 = 1
        } else {
            self.binary8 = 0
        }
        
       let userBinary  = "\(self.binary8)\(self.binary7)\(self.binary6)\(self.binary5)\(self.binary4)\(self.binary3)\(self.binary2)\(self.binary1)"
        
        if (userBinary == self.correctBinary) {
            
            
            let digits:[Int] = Array(String(stringInterpolationSegment: self.correctBinary!).characters).map { Int(String($0))! }
            
            var binaryNumber: [Int]!
            binaryNumber = digits
                        
            for var i = 0; i < binaryNumber.count; i++ {
                if (binaryNumber[i] == 0) {
                    // LIGHT BULB OFF
                } else {
                   // LIGHT BULB ON
                    findIndex(i, visualizeMode: false)
                }
            }

            
            // MARK: Success Alert
            let alert = UIAlertController(title: "Success", message: "Great Job. You entered the correct number in binary!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Success", style: UIAlertActionStyle.Default, handler:   {(alert :UIAlertAction!) in
                
                self.gameTimer = NSTimer.scheduledTimerWithTimeInterval(
                    1.0,
                    target: self,
                    selector: Selector("timer"),
                    userInfo: nil,
                    repeats: true)
                
                    }))
            
         
            
                
            self.presentViewController(alert, animated: true, completion: {})
            
            self.didRecieveIncomingAlert()
            
            self.prepareAudios("success")
            self.ding.play()
            self.resetBulbs(0)
            
        } else {
            
            for i in 1..<11 {
                self.didRequestBulbChange(i, bulbState: "true", isError: true)
            }
            
        
            NSTimer.scheduledTimerWithTimeInterval(
                4.0,
                target: self,
                selector: Selector("turnOffBulbs"),
                userInfo: nil,
                repeats: false)
            
            // MARK: Error alert
            // ERROR OCCURED, SHOW BULBS ASha RED
            let alert = UIAlertController(title: "Error", message: "Bummer. The binary you entered is incorrect.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler:
                {(alert :UIAlertAction!) in
                    self.gameTimer = NSTimer.scheduledTimerWithTimeInterval(
                        1.0,
                        target: self,
                        selector: Selector("timer"),
                        userInfo: nil,
                        repeats: true)
                    }))

            self.presentViewController(alert, animated: true, completion: {
                
            self.prepareAudios("error")
            self.ding.play()
 
            })

        }
    }
    

    func turnOffBulbs() {
        GMLight().turnOffLights()
    }
    func didRecieveIncomingAlert() {
       self.gameTimer?.invalidate()
    }
    
    
    func Reset() {
        resetBulbs(0)
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
        for i in 1..<10 {
            didRequestBulbChange(i, bulbState: "true", isError: false)
        }
    }
    @IBAction func minusPressed(sender: AnyObject) {
        
        
        if self.randomNumber > 0 {
            self.randomNumber--
            self.randomNumberLabel.text = "\(self.randomNumber)"
            
            randomNumber(self.randomNumber)
            
            print("Correct binary is \(correctBinary!)")
            
            NSTimer.scheduledTimerWithTimeInterval(
                3.0,
                target: self,
                selector: Selector("turnOffBulbs"),
                userInfo: nil,
                repeats: false)
            
            
            let digits:[Int] = Array(String(stringInterpolationSegment: self.correctBinary!).characters).map { Int(String($0))! }
            
            var digitsArray = [Int]()
            for (index, item) in digits.enumerate() {
                print("Item \(index): \(item)")
                
                if (item == 1) {
                    print("Index is \(index))")
                    
                    let light = GMLight()
                    light.bulbOn(index + 1, bulbState: "true")
                    
                    //self.didRequestBulbChange(index + 1, bulbState: "true", isError: false)
                }
                digitsArray.append(item)
            }
        
        }
    }
    // MARK: Plus Button Pressed
    
    @IBAction func plusPressed(sender: AnyObject) {
        if self.randomNumber < 512 {
            self.randomNumber++
            self.randomNumberLabel.text = "\(self.randomNumber)"
            
            randomNumber(self.randomNumber)

            print("Correct binary is \(correctBinary!)")

             NSTimer.scheduledTimerWithTimeInterval(
                3.0,
                target: self,
                selector: Selector("turnOffBulbs"),
                userInfo: nil,
                repeats: false)
            
            
            let digits:[Int] = Array(String(stringInterpolationSegment: self.correctBinary!).characters).map { Int(String($0))! }
            
            var digitsArray = [Int]()
            for (index, item) in digits.enumerate() {
                print("Item \(index): \(item)")

                if (item == 1) {
                    print("Index is \(index))")
                
                    let light = GMLight()
                    light.bulbOn(index + 1, bulbState: "true")
                    
                    //self.didRequestBulbChange(index + 1, bulbState: "true", isError: false)
                }
                digitsArray.append(item)
            }
            
            print("Digits array is \(digitsArray)")
            
        
            for i in digitsArray {
               
                if i == 1 {
                    let y: Int? = digitsArray.indexOf(i)!
                    print("Index of i is \(y!)")
                    
                    // Bulb is ON
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            // update some UI
                        }
                    }
                    
                } else {
            
                }
            
            }
            
            
            let userBinary  = "\(self.binary8)\(self.binary7)\(self.binary6)\(self.binary5)\(self.binary4)\(self.binary3)\(self.binary2)\(self.binary1)"
            
            if (userBinary == self.correctBinary) {
                
                
                let digits:[Int] = Array(String(stringInterpolationSegment: self.correctBinary!).characters).map { Int(String($0))! }
                
                var binaryNumber: [Int]!
                binaryNumber = digits
                
                for var i = 0; i < binaryNumber.count; i++ {
                    if (binaryNumber[i] == 0) {
                        // LIGHT BULB OFF
                    } else {
                        // LIGHT BULB ON
                        findIndex(i, visualizeMode: false)
                    }
                }
            }
            
            }

    }
    
    func didTurnOffTimer() {
        for i in 1..<10 {
            didRequestBulbChange(i, bulbState: "false", isError: false)
        }
    }
    
    func prepareAudios(fileName: String) {
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")
        do {
            try self.ding = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), fileTypeHint: nil)
            self.ding.prepareToPlay()
        } catch {
            
        }
        
    }
    
    @IBAction func endGamePressed(sender: AnyObject) {
        print("End Game")
        NSUserDefaults.standardUserDefaults().setInteger(self.counter, forKey: "highscore")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}


extension Array {
    func find(includedElement: Element -> Bool) -> Int? {
        for (idx, element) in enumerate() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
    
}