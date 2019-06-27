//
//  Die.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/18/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import Foundation

struct Die: Hashable, CustomStringConvertible {
    
    public let sides: Int
    public let color: DieColor
    
    init(_ sides: Int) {
        self.sides = sides
        self.color = .none
    }
    
    public var description: String {
        return "d\(sides)"
    }
    
    init(sides: Int, color: DieColor) {
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
