//
//  Exercise.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Exercise: NSObject {
    
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












