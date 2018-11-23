//
//  Exercise.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Exercise: NSObject, Codable {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(reps, forKey: "reps")
        aCoder.encode(sets, forKey: "sets")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(rest, forKey: "rest")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
        let reps = aDecoder.decodeObject(forKey: "reps") as? Double,
        let sets = aDecoder.decodeObject(forKey: "sets") as? Double,
        let weight = aDecoder.decodeObject(forKey: "weight") as? Double,
        let rest = aDecoder.decodeObject(forKey: "rest") as? Double
        else {
            return nil
        }
        self.init(names: name, repss: reps, setss: sets, weights: weight, rests: rest)
    }
    
    
    private var name: String?
    private var reps: Double?
    private var sets: Double?
    private var weight: Double?
    private var rest: Double?
    
    init(names:String, repss:Double, setss: Double, weights: Double, rests: Double ) {
        self.name = names
        self.reps = repss
        self.sets = setss
        self.weight = weights
        self.rest = rests
    }
    
    
    
    
    func setName(names: String) {
        name = names
    }
    func getName() -> String {
        return name!
    }
    
    
    func setReps(repss: String) {
        reps = Double(repss)!
    }
    func getReps() -> Double {
        return reps!
    }
    
    
    func setSets(setss: String) {
        sets = Double(setss)!
    }
    func getSets() -> Double {
        return sets!
    }
    
    func setWeight(weights: String) {
        weight = Double(weights)!
    }
    func getWeight() -> Double {
        return weight!
    }
    
    
    func setRest(rests: String) {
        rest = Double(rests)!
    }
    func getRest() -> Double {
        return rest!
    }
    
    
    
}












