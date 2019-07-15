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
    
    // The "dice" are stored in an array of tuples, where the type is stored as a Die, and the amount is stored as an Integer.
    private var dice = [(type: Die, amount: Int)]()
    
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
        
        return dice.count
        
    }
    
    // This function returns the given die type's position in the dice array. If there are no dice of the given type, -1 is returned.
    private func dieTypePositionInArray(_ targetType: Die) -> Int {
        
        if dice.isEmpty { return -1 }
        
        var position = 0 // TODO: Is there a better way to track the position? Like the for-while structure or something?
        for (type, _) in dice {
            if type == targetType {
                return position
            }
            position += 1
        }
        
        return -1 // If we've exited the for-in loop, that means we've gone through the whole array and haven't found the die type.
        
    }
    
    public mutating func addDie(_ die: Die) {
        
        let position = dieTypePositionInArray(die)
        if position == -1 {
            dice.append((type: die, amount: 1))
        } else {
            dice[position].amount += 1
        }
        
    }
    
    // Returns an array of tuples indicating the amounts of different types of dice in the Tower.
//    public func getDiceArray() -> [(number: Int, type: Die)]? {
//
//        if dice.isEmpty { return nil }
//
//        var diceArray = [(number: Int, type: Die)]()
//        for (type, amount) in dice {
//            let diceTuple = (number: amount, type: type)
//            diceArray.append(diceTuple)
//        }
//
//        return diceArray
//
//    }
    
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
    
    public func getDie(atArrayPosition position: Int) -> (type: Die, amount: Int)? {
        
        return dice[position]
        
    }
    
    public mutating func clearDice() {
        
        if !dice.isEmpty {
            dice.removeAll() // TODO: Does removeAll() acheive the same effect as setting dice to a new empty array?
        }
        
    }
    
}
