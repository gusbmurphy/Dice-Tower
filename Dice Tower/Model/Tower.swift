//
//  Tower.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/18/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import Foundation

// The "Tower" struct stores dice, and also rolls them.

struct Tower {
    
    private var dice = [Die]()
    
    public var amountOfDice: Int {
        
        if dice.isEmpty { return 0 }
        
        var totalAmount = 0
        for die in dice {
            totalAmount += die.amount
        }
        
        return totalAmount

    }
    
    public var amountOfSides: Int {
        
        if dice.isEmpty { return 0 }
        
        var totalAmount = 0
        for die in dice {
            totalAmount += die.sides * die.amount
        }
        
        return totalAmount
        
    }
    
    // Dice are considered the same type if they have the same amount of sides, but not if they are different colors.
    public var amountOfDieTypes: Int {
        return dice.count
    }
    
    public mutating func addDie(_ die: Die) {
        
        // If this type of die has already been added, then we want to increment it by one, otherwise we need to add it in for the first time.
        let indexOfExistingDie = dice.firstIndex(of: die)
        
        if indexOfExistingDie == nil {
            dice.append(die)
        } else {
            dice[indexOfExistingDie!].amount += die.amount
        }
        
    }
    
    public func getDie(for indexPath: IndexPath) -> Die? {
        return dice[indexPath.row]
    }
    
    // TODO: This function may not need to exist at all (it was created before there was a collection view), but right now it doesn't pay attention to the color of dice.
    public func diceString() -> String {
        
        var diceString = ""
        if dice.isEmpty { return diceString }
        
        // If there's only one type of die, we'll want to display it slightly differently.
        if dice.count == 1 {
            diceString = "\(amountOfDice)d\(amountOfSides)"
        } else {
        
            for die in dice {
                // If there are already dice represented in the String, we need to add a seperation.
                if diceString != "" {
                    diceString += " + "
                }
                
                diceString += "(\(die.amount)d\(die.sides))"
            }
            
        }
        
        return diceString
        
    }
    
    public func cumulativeRoll() -> Int? {
        
        if dice.isEmpty { return nil }
        
        let result = Int.random(in: amountOfDice...amountOfSides)
        return result
        
    }
    
    // This function returns the probability as a rounded Integer ready to be used as a percentage.
    public func calculateProbabilty(_ target: Int) -> Int {
        
        if target > amountOfSides {
            return 0
        }
        
        let favorableOutcomes = amountOfSides - target
        let possibleOutcomes = amountOfSides - amountOfDice
        let probability = Double(favorableOutcomes) / Double(possibleOutcomes)
        
        if probability > 1 {
            return 100
        }
        
        let probabiltyAsRoundedPercentage = Int(round(100.0 * probability))
        return probabiltyAsRoundedPercentage
        
    }
    
    public mutating func clearDice() {
        
        if !dice.isEmpty {
            dice = [Die]()
        }
        
    }
    
}
