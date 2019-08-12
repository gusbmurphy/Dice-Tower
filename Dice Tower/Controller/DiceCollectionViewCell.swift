//
//  DiceCollectionView.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/27/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import UIKit

class DiceCollectionViewCell: UICollectionViewCell {
    
    public var die: Die? {
        didSet {
            dieLable.text = die!.description
        }
    }
    
    private let dieImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 0.23, green: 0.59, blue: 0.47, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let dieLable: UILabel = {
        
        let lable = UILabel(frame: CGRect.zero)
        lable.textColor = UIColor.white
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        dieImageView.addSubview(dieLable)
        addSubview(dieImageView)
        
        // Add auto-layout constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": dieImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": dieImageView]))
        
        dieLable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dieLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
    }
    
}
