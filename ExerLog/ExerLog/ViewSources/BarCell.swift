//
//  BarCell.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-25.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit


class BarCell: UICollectionViewCell {
    
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.greens
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(barView)
        
        //barView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300);barHeightConstraint?.isActive = true
        
        barHeightConstraint?.constant = 100
        
        
        // barView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
}
