//
//  Sets.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-24.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Sets: NSObject, Codable {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(reps, forKey: "reps")
        aCoder.encode(setNum, forKey: "sets")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(rest, forKey: "rest")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let reps = aDecoder.decodeObject(forKey: "reps") as? Double,
            let sets = aDecoder.decodeObject(forKey: "setz") as? Double,
            let weight = aDecoder.decodeObject(forKey: "weight") as? Double,
            let rest = aDecoder.decodeObject(forKey: "rest") as? Double
            else {
                return nil
        }
        self.init(reps: reps, setNumb: Int(sets), weight: weight, rest: rest)
    }
    
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
    
    func getSetNum() -> Int {
        return self.setNum
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
