//
//  DiaryCell.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-07.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit


class DiaryCell: UICollectionViewCell {
    
    static let green = UIColor(red:0.02, green:0.66, blue:0.18, alpha:1.0)
    
    let rowView: UIView = {
        let view = UIView()
        view.backgroundColor = green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(rowView)
        
        //barView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        barHeightConstraint = rowView.heightAnchor.constraint(equalToConstant: 50);barHeightConstraint?.isActive = true
        
        barHeightConstraint?.constant = 50
        
        
        rowView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = false
        rowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        rowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
}

}
