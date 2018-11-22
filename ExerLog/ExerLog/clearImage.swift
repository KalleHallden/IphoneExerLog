//
//  clearImage.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-21.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    var imageRepresentation : UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
