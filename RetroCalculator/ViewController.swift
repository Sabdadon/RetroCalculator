//
//  ViewController.swift
//  RetroCalculator
//
//  Created by sabarish sridhar on 14/02/17.
//  Copyright © 2017 sabarish. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    enum Operation : String
    {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }
    var currentOperation = Operation.Empty
    var btnSound:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
       
        do{
        try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
        
        
    }

    @IBAction func numberPressed(sender:UIButton)
    {
        playSound();
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func equals(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    @IBAction func add(_ sender: Any) {
        processOperation(operation: .Add)
    }
    @IBAction func sub(_ sender: Any) {
        processOperation(operation: .Subtract)
    }
    @IBAction func mul(_ sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func div(_ sender: Any) {
        processOperation(operation: .Divide)
    }
    func playSound(){
        if btnSound.isPlaying{
        btnSound.stop()
        }
        btnSound.play()
    }
    func processOperation(operation :Operation)
    {
    if currentOperation != Operation.Empty
    {
        if runningNumber != ""
        {
            rightValStr = runningNumber
            runningNumber = ""
            if currentOperation == Operation.Multiply{
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            }
            else if currentOperation == Operation.Divide{
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            }
            else if currentOperation == Operation.Subtract{
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
            else if currentOperation == Operation.Add{
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            leftValStr = result
            outputLbl.text = result
            
        }
        currentOperation = operation
        }
        
    else{
        leftValStr = runningNumber
        runningNumber = ""
        currentOperation = operation
        }
    }
   
    
}

