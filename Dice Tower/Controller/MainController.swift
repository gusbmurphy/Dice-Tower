//
//  ViewController.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/16/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var diceCollectionView: UICollectionView!
    @IBOutlet weak var resultDisplayLabel: UILabel!
    @IBOutlet weak var probabiltyDisplayLabel: UILabel!
    @IBOutlet weak var probabilityTargetLabel: UILabel!
    
    private var die: Die?
    private var tower = Tower()
    private var numberOfDice = 0 // This variable is only to be used to debug the dice collection view!
    
    let uiDispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        resultDisplayLabel.text = ""
//        addNumPadDoneButton()
        
        diceCollectionView.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        diceCollectionView.register(DiceCollectionViewCell.self, forCellWithReuseIdentifier: "DieCell")
        
        let collectionLayout = DiceCollectionViewLayout()
        collectionLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        diceCollectionView.collectionViewLayout = collectionLayout
        
    }
    
    @IBAction func dieButtonPressed(_ sender: UIButton) {
        
        let numOfSides = Int(sender.tag)
        let newDie = Die(numOfSides)
        tower.addDie(newDie)
        
        // Update UI
        uiDispatchGroup.enter()
        diceCollectionView.reloadData()
        uiDispatchGroup.leave()
        
        uiDispatchGroup.notify(queue: DispatchQueue.main) {
            self.diceCollectionView.contentInset.top = max((self.diceCollectionView.frame.height - self.diceCollectionView.contentSize.height) / 2, 0)
        }
        
        updateProbability()
        
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        if let result = tower.cumulativeRoll() {
            resultDisplayLabel.text = String(result)
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        tower.clearDice()
        diceCollectionView.reloadData()
        resultDisplayLabel.text = ""
        
    }
    
    // MARK: Probability Feature
    
    @IBAction func probabilityTargetMinusButton(_ sender: Any) {
        modifyProbabilityTarget(-1)
    }
    
    @IBAction func probabilityTargetPlusButton(_ sender: Any) {
        modifyProbabilityTarget(1)
        
    }
    
    fileprivate func modifyProbabilityTarget(_ increment: Int) {
        
        if let oldTarget = Int(probabilityTargetLabel.text!) {
            let newTarget = oldTarget + increment
            if newTarget < 0 {
                probabilityTargetLabel.text! = String(0)
            } else {
                probabilityTargetLabel.text! = String(newTarget)
            }
            updateProbability()
        }
        
    }
    
    fileprivate func updateProbability() {
        
        if let probabilityTarget = Int(probabilityTargetLabel.text!) {
            let probability = tower.calculateProbabilty(probabilityTarget)
            probabiltyDisplayLabel.text = "\(probability)%"
        }
        
    }
    
//    // TODO: Figure out what's going on in this function!
//    fileprivate func addNumPadDoneButton() {
//
//        let toolBar: UIToolbar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.blackTranslucent
//        toolBar.items=[
//            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
//            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(numPadDonePressed))]
//        toolBar.sizeToFit()
//
//        probabiltyTargetField.inputAccessoryView = toolBar
//
//    }
//
//    @objc fileprivate func numPadDonePressed() {
//        probabiltyTargetField.resignFirstResponder()
//    }
    
}

//extension MainController: UITextFieldDelegate {
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        updateProbability()
//    }
//
//}

// MARK: Collection View Delegate/Datasource Functions

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tower.amountOfDieTypes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DieCell", for: indexPath) as! DiceCollectionViewCell
        let dieInfo = tower.getDie(atArrayPosition: indexPath.row)
        cell.dieText = "\(dieInfo!.amount)\(dieInfo!.type)"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
