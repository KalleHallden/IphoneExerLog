//
//  textFieldExt.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-21.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder(isDark: Bool, lineColor: UIColor) {
        self.font = UIFont(name: "Avenir next", size: 16.0)!
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.borderStyle = .none
        if (isDark) {
            self.layer.backgroundColor = UIColor.black.cgColor
        }
        
        self.layer.masksToBounds = false
        if (isDark) {
            self.layer.shadowColor = UIColor.white.cgColor
        } else {
            self.layer.shadowColor = lineColor.cgColor
        }
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
