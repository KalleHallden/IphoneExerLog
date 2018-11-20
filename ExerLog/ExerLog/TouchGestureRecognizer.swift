//
//  TouchGestureRecognizer.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-20.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class TouchGestureRecognizer: UIGestureRecognizer {
    
    var isLongPress: Bool = false
    fileprivate var startDateInterval: TimeInterval = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began
        self.startDateInterval = Date().timeIntervalSince1970
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
        self.isLongPress = (Date().timeIntervalSince1970 - self.startDateInterval) > 1.0
    }
}
