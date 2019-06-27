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
    
    // The "dice" are stored in a dictionary where the keys are the types of dice (color and sides), and the value is how many of that type there are.
    private var dice = [Die: Int]()
    
    public var amountOfDice: Int {
        
        if dice.isEmpty { return 0 }
        
        var totalAmount = 0
        for (_, amount) in dice {
            totalAmount += amount
        }
        
        return totalAmount

    }
    
    public var amountOfSides: Int {
        
        if dice.isEmpty { return 0 }
        
        var totalAmount = 0
        for (type, amount) in dice {
            totalAmount += type.sides * amount
        }
        
        return totalAmount
        
    }
    
    public var amountOfDieTypes: Int {
        
        return dice.keys.count
        
    }
    
    public mutating func addDie(_ die: Die) {
        
        // If this type of die has already been added, then we want to increment it by one, otherwise we need to add it in for the first time.
        let typeExistsInDictionary = dice[die] != nil
        
        if typeExistsInDictionary {
            dice[die] = dice[die]! + 1
        } else {
            dice[die] = 1
        }
        
    }
    
    // Returns an array of tuples indicating the amounts of different types of dice in the Tower.
    public func getDiceArray() -> [(number: Int, type: Die)]? {
        
        if dice.isEmpty { return nil }
        
        var diceArray = [(number: Int, type: Die)]()
        for (type, amount) in dice {
            let diceTuple = (number: amount, type: type)
            diceArray.append(diceTuple)
        }
        
        return diceArray
        
    }
    
    // TODO: This function may not need to exist at all, but right now it doesn't pay attention to the color of dice.
    public func diceString() -> String {
        
        var diceString = ""
        if dice.isEmpty { return diceString }
        
        // If there's only one type of die, we'll want to display it slightly differently.
        if dice.count == 1 {
            diceString = "\(amountOfDice)d\(amountOfSides)"
        } else {
        
            for (die, number) in dice {
                // If there are already dice represented in the String, we need to add a seperation.
                if diceString != "" {
                    diceString += " + "
                }
                
                diceString += "(\(number)d\(die.sides))"
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
            dice = [Die: Int]()
        }
        
    }
    
}
