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
    
    override var isSelected: Bool {
        didSet {
            print("Highlighted")
            barView.backgroundColor = isHighlighted ? Colors.darkGreen : Colors.greens
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)

        }
    }
    var barHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        
//        let color = Colors()
//        color.setColors()
        addSubview(barView)
        
        //barView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300);barHeightConstraint?.isActive = true
        
        barHeightConstraint?.constant = 100
        
        
        // barView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        
    }
    var barHeightAnimationShouldHappen = false
    func barHeightAnimation(viewHeight: Int) {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: CGFloat(viewHeight))
        }) { (finished) in
            UIView.animate(withDuration: 0.5, delay: 0.3, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    var hasbeen = false
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func setBackgroundColor(hasBeenPressed: Bool) {
//        let color = Colors()
//        color.setColors()
        if (hasBeenPressed) {
            if (hasbeen) {
                print("Hi")
                barView.backgroundColor = Colors.greens
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
                hasbeen = false
            } else {
                barView.backgroundColor = Colors.darkGreen
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                        self.transform = CGAffineTransform(scaleX: 1.8, y: 1)
                    }, completion: nil)
                hasbeen = true
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
            barView.backgroundColor = Colors.greens
        }
    }
    
    
}
