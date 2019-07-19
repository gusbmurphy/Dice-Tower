//
//  DiceCollectionViewLayout.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 7/2/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import UIKit

class DiceCollectionViewLayout: UICollectionViewFlowLayout {
    
    fileprivate var rows = [DiceCollectionViewRow]()
    
    // TODO: This gets called twice everytime when I think it should only be called once, why?
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // TODO: The default implementation of layoutAttributesForElements returns nil, does that mean it returns an array of UICollectionViewLayoutAttributes who each have nil for a crucial value? How does this call to the super class return anything?
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        if attributes.count != 0 {
        
            var currentRowY: CGFloat = -1 // This is initialized to -1 so that the first iteration of the if statement in the for loop will be triggered.
            
            for attribute in attributes {
                // If the current attribute has a new Y offset, that means it will belong in a new row, otherwise we just add it into the last row that we're working with.
                if currentRowY != attribute.frame.origin.y {
                    currentRowY = attribute.frame.origin.y
                    rows.append(DiceCollectionViewRow(spacing: 10))
                }
                rows.last?.add(attribute: attribute)
            }
            
            // Center each row horizontally.
            rows.forEach { $0.centerRowHorizontally(collectionViewWidth: collectionView?.frame.width ?? 0) }
            return rows.flatMap { $0.attributes }
            
        }
        
        return attributes
        
    }
    
}

private class DiceCollectionViewRow {
    
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0
    
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    // The rowWidth is calculated by first adding up all the frame widths of the elements represented in the row (using the reduce function), and then adding the spacing. Since there are only spaces between the elements, we use "attributes.count - 1".
    var rowWidth: CGFloat {
        
        var width: CGFloat = attributes.reduce(0, { result, attribute -> CGFloat in
            return result + attribute.frame.width
        })
        width += CGFloat(attributes.count - 1) * spacing
        return width
        
    }
    
    // The rowHeight assumes that all of the elements in the row are of the same height (the height of the first element).
    var rowHeight: CGFloat {

        let height: CGFloat = attributes[0].frame.height
        return height

    }
    
    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }
    
    func centerRowHorizontally(collectionViewWidth: CGFloat) {
        let padding = (collectionViewWidth - rowWidth) / 2
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + spacing
        }
    }
    
}
