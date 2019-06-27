//
//  DiceCollectionView.swift
//  Dice Tower
//
//  Created by Augustus Murphy on 6/27/19.
//  Copyright © 2019 Augustus Murphy. All rights reserved.
//

import UIKit

class DiceCollectionViewCell: UICollectionViewCell {
    
    public var dieText: String? {
        didSet {
            dieLable.text = dieText
        }
    }
    
    let dieImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let dieLable: UILabel = {
        
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        lable.textColor = UIColor.black
        return lable
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.blue
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        dieImageView.addSubview(dieLable)
        addSubview(dieImageView)
        // Add auto-layout constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": dieImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": dieImageView]))
    }
    
}
