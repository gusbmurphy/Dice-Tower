//
//  Die.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/18/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import Foundation

struct Die: Hashable, CustomStringConvertible {
    
    public var amount: Int
    public let sides: Int
    public let color: DieColor
    
    public var description: String {
        return "\(amount)d\(sides)"
    }
    
    init(_ sides: Int) {
        self.amount = 1
        self.sides = sides
        self.color = .none
    }
    
    init(_ sides: Int, color: DieColor) {
        self.amount = 1
        self.sides = sides
        self.color = color
    }
    
    init(amount: Int, sides: Int, color: DieColor) {
        self.amount = amount
        self.sides = sides
        self.color = color
    }
    
    static func == (lhs: Die, rhs: Die) -> Bool {
        return lhs.sides == rhs.sides && lhs.color == rhs.color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sides)
        hasher.combine(color)
    }
    
}
