//
//  Exercise2.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-24.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Exercise2 {
    private var name = ""
    private var setsOfExercise = [Sets]()
    
    func setName(name: String) {
        self.name = name
    }
    func getSetsOfExercises() -> [Sets] {
        return setsOfExercise
    }
    func getRepsOfExercise() -> Double {
        var totalReps = 0.0
        for set in self.setsOfExercise {
           totalReps += set.getReps()
        }
        return totalReps
    }
    func getName() -> String {
        return self.name
    }
    
    init(name: String) {
        self.name = name
    }
    func addSetOfExercise(reps: Double, sets: Double, weight: Double, rest: Double) {
        let numofSets = Int(sets)
        for set in 0...numofSets {
            let newSet = Sets(reps: reps, setNumb: set, weight: weight, rest: rest)
            self.setsOfExercise.append(newSet)
        }
    }
}

