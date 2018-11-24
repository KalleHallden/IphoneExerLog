//
//  Sets.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-24.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Sets {
    private var reps: Double = 0.0
    private var setNum: Int = 0
    private var weight: Double = 0.0
    private var rest: Double = 0.0
    
    init(reps: Double, setNumb: Int, weight: Double, rest: Double) {
        self.reps = reps
        self.setNum = setNumb
        self.weight = weight
        self.rest = rest
    }
    
    func getReps() -> Double {
        return self.reps
    }
    func getWeight() -> Double {
        return self.weight
    }
    func getRest() -> Double {
        return self.rest
    }
}
