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
    
    // The "dice" are stored in a dictionary where the keys are the number of sides, and the value is how many dice of that type there are
    private var dice = [Int: Int]()
    
    private var amountOfDice: Int {
        
        if dice.isEmpty { return 0 }
        
        var totalAmount = 0
        for (_, amount) in dice {
            totalAmount += amount
        }
        
        return totalAmount

    }
    
    private var amountOfSides: Int {
        
        if dice.isEmpty { return 0 }
        
        var totalAmount = 0
        for (type, amount) in dice {
            totalAmount += type * amount
        }
        
        return totalAmount
        
    }
    
    public mutating func addDie(_ die: Die) {
        
        // If this type of die has already been added, then we want to increment it by one, otherwise we need to add it in for the first time
        let typeExistsInDictionary = dice[die.sides] != nil
        
        if typeExistsInDictionary {
            dice[die.sides] = dice[die.sides]! + 1
        } else {
            dice[die.sides] = 1
        }
        
    }
    
    public func diceString() -> String {
        
        var diceString = ""
        if dice.isEmpty { return diceString }
        
        // If there's only one type of die, we'll want to display it slightly differently
        if dice.count == 1 {
            diceString = "\(amountOfDice)d\(amountOfSides)"
        } else {
        
            for (type, number) in dice {
                // If there are already dice represented in the String, we need to add a seperation
                if diceString != "" {
                    diceString += " + "
                }
                
                diceString += "(\(number)d\(type))"
            }
            
        }
        
        return diceString
        
    }
    
    public func cumulativeRoll() -> Int? {
        
        if dice.isEmpty { return nil }
        
        let result = Int.random(in: amountOfDice...amountOfSides)
        return result
        
    }
    
    // This function returns the probability as a rounded Integer ready to be used as a percentage
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
            dice = [Int: Int]()
        }
        
    }
    
}
