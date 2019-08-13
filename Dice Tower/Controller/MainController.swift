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
    
    private var die: Die?
    private var tower = Tower()
    private var numberOfDice = 0 // This variable is only to be used to debug the dice collection view!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        resultDisplayLabel.text = ""
        diceCollectionView.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        diceCollectionView.register(DiceCollectionViewCell.self, forCellWithReuseIdentifier: "DieCell")
        
        configureCellLayout()
        
    }
    
    fileprivate func configureCellLayout() {
        
        let layout = diceCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = CGFloat(10)
        
        let numberOfColumns = 3
        let cellHeight = (diceCollectionView.frame.size.height - layout.minimumInteritemSpacing * CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns)
        layout.itemSize = CGSize(width: cellHeight, height: cellHeight)
        
    }
    
    @IBAction func dieButtonPressed(_ sender: UIButton) {
        
        let numOfSides = Int(sender.tag)
        let newDie = Die(numOfSides)
        let addedDie = tower.addDie(newDie)
        
        // Update the Collection View: if we have created a new die type, we will use insertItems() at the end.
        let indexPath = IndexPath(row: addedDie.index, section: 0)
        if addedDie.isNewDie {
            diceCollectionView.insertItems(at: [indexPath])
        } else {
            diceCollectionView.reloadItems(at: [indexPath])
        }
        
        updateProbability()
        
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        if let result = tower.cumulativeRoll() {
            resultDisplayLabel.text = String(result)
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        if tower.hasDice {
            
            tower.clearDice()
            
            diceCollectionView.performBatchUpdates({
                for i in 0 ..< diceCollectionView.numberOfItems(inSection: 0) {
                    diceCollectionView.deleteItems(at: [IndexPath(row: i, section: 0)])
                }
            }, completion: nil)
            
            resultDisplayLabel.text = ""
            probabiltyDisplayLabel.text = ""
            
        }
        
    }
    
    // MARK - Probability Members
    
    @IBOutlet weak var equalToButton: UIButton!
    @IBOutlet weak var lessThanButton: UIButton!
    @IBOutlet weak var greaterThanButton: UIButton!
    
    private let greenOff: UIColor = UIColor(red:0.16, green:0.37, blue:0.32, alpha:1.0)
    private let greenOn: UIColor = UIColor(red:0.27, green:0.65, blue:0.55, alpha:1.0)
    
    private var equalToIsOn: Bool = true {
        didSet {
            equalToButton.backgroundColor = equalToIsOn ? greenOn : greenOff
        }
    }
    private var lessThanIsOn: Bool = false {
        didSet {
            lessThanButton.backgroundColor = lessThanIsOn ? greenOn : greenOff
        }
    }
    private var greaterThanIsOn: Bool = true {
        didSet {
            greaterThanButton.backgroundColor = greaterThanIsOn ? greenOn : greenOff
        }
    }
    
    @IBOutlet weak var comparisionTargetLabel: UILabel!
    @IBOutlet weak var probabiltyDisplayLabel: UILabel!
    
    private var comparisionTarget: Int = 1 {
        didSet {
            comparisionTargetLabel.text = String(comparisionTarget)
        }
    }
    
}

extension MainController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateProbability()
    }
    
}

// MARK: Collection View Delegate/Datasource Functions

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tower.amountOfDieTypes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DieCell", for: indexPath) as! DiceCollectionViewCell
        
        cell.die = tower.getDie(for: indexPath)
        
        return cell
        
    }
    
}

// MARK: Probability Button Functions

extension MainController {
    
    @IBAction func equalToButtonPressed(_ sender: Any) {
        equalToIsOn = !equalToIsOn
    }
    
    @IBAction func lessThanButtonPressed(_ sender: Any) {
        lessThanIsOn = !lessThanIsOn
        // This if statement (and the mirror one in greaterThanButtonPressed) ensures that we never have both greater than and less than on at the same time.
        if greaterThanIsOn {
            greaterThanIsOn = false
        }
    }
    
    @IBAction func greaterThanButtonPressed(_ sender: Any) {
        greaterThanIsOn = !greaterThanIsOn
        if lessThanIsOn {
            lessThanIsOn = false
        }
    }
    
    @IBAction func comparisionTargetDecrementButtonPressed(_ sender: Any) {
        comparisionTarget -= 1
        updateProbability()
    }
    
    @IBAction func comparisionTargetIncrementButtonPressed(_ sender: Any) {
        comparisionTarget += 1
        updateProbability()
    }
    
    fileprivate func updateProbability() {
        
        let probability = calculateProbability()
        probabiltyDisplayLabel.text = "\(probability)%"
        
    }
    
    fileprivate func calculateProbability() -> Int {
        
        return 100
        
        // TODO: Figure out the correct math for these difference calculations!
        
        var favorableOutcomes: Int?
        let possibleOutcomes = tower.amountOfSides - tower.amountOfDice
        
        if equalToIsOn {
            if !lessThanIsOn && !greaterThanIsOn {
                // Strictly equals.
                
            } else if lessThanIsOn {
                // Less than or equal to.
            } else {
                // Greater than or equal to.
            }
        } else {
            if lessThanIsOn {
                // Strictly less than.
            } else {
                // Strictly greater than.
            }
        }
        
//        let probability = Double(favorableOutcomes!) / Double(possibleOutcomes)
//
//        if probability > 1 {
//            return 100
//        }
//
//        let probabiltyAsRoundedPercentage = Int(round(100.0 * probability))
//        return probabiltyAsRoundedPercentage
        
    }
    
}
