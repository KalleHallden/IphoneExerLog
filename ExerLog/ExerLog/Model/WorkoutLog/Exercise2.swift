//
//  Exercise2.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-24.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Exercise2: NSObject, Codable {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(setsOfExercise, forKey: "sets")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let sets = aDecoder.decodeObject(forKey: "sets") as? [Sets]
            else {
                return nil
        }
        self.init(name: name, sets: sets)
    }
    
    private var name = ""
    private var setsOfExercise = [Sets]()
    
    func setName(name: String) {
        self.name = name
    }
    func getSetsOfExercises() -> [Sets] {
        return setsOfExercise
    }
    func getSets() -> Int {
        var numOfSets = 0
        for set in self.getSetsOfExercises() {
            numOfSets += set.getSetNum()
        }
        return numOfSets
    }
    func clearSets() {
        setsOfExercise.removeAll()
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
    init(name: String, sets: [Sets]) {
        self.name = name
        self.setsOfExercise = sets
    }
    var count = 0
    
    func addSetOfExercise(reps: Double, sets: Double, weight: Double, rest: Double, isNew: Bool) {
        if (sets > 0) {
            let newSet = Sets(reps: reps, setNumb: Int(sets), weight: weight, rest: rest)
            self.setsOfExercise.append(newSet)
            print("This is what could be: \(self.setsOfExercise.count)")
        }
    }
}

