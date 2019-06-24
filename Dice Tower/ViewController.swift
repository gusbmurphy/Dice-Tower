//
//  ViewController.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/16/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceTextView: UITextView!
    @IBOutlet weak var resultDisplayLabel: UILabel!
    @IBOutlet weak var probabiltyDisplayLabel: UILabel!
    @IBOutlet weak var probabiltyTargetField: UITextField!
    
    private var die: Die?
    private var tower = Tower()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        resultDisplayLabel.text = ""
        diceTextView.text = ""
        
        addNumPadDoneButton()
        
    }
    
    fileprivate func updateProbability() {
        
        if let probabilityTarget = Int(probabiltyTargetField.attributedText!.string) {
            let probability = tower.calculateProbabilty(probabilityTarget)
            probabiltyDisplayLabel.text = "\(probability)%"
        }
        
    }
    
    @IBAction func dieButtonPressed(_ sender: UIButton) {
        
        let numOfSides = Int(sender.tag)
        let newDie = Die(numOfSides)
        tower.addDie(newDie)
        
        diceTextView.text = tower.diceString()
        
        updateProbability()
        
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        if let result = tower.cumulativeRoll() {
            resultDisplayLabel.text = String(result)
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        tower.clearDice()
        diceTextView.text = ""
        resultDisplayLabel.text = ""
        
    }
    
    fileprivate func addNumPadDoneButton() {
        
        // TODO: Figure out what's going on in this code!
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(numPadDonePressed))]
        toolBar.sizeToFit()
        
        probabiltyTargetField.inputAccessoryView = toolBar
        
    }
    
    @objc fileprivate func numPadDonePressed() {
        probabiltyTargetField.resignFirstResponder()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateProbability()
    }
    
}
