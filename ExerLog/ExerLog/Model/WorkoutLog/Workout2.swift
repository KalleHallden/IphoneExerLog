//
//  Workout2.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-24.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Workout2 {
    private var exerciseList = [Exercise2]()
    private var weightVolume: Double = 0.0
    private var totalSets: Double = 0
    private var totalReps: Double = 0
    private var workoutDate = Date()
    private var id = -1
    
//    init(weightVol:Double, totReps:Double, totSets: Double, exerciseLst: [Exercise2], theDate: Date, theID: Int ) {
//        self.weightVolume = weightVol
//        self.totalSets = totSets
//        self.totalReps = totReps
//        self.exerciseList = exerciseLst
//        self.workoutDate = theDate
//        self.id = theID
//    }
//    
//    override init() {}
    
    func setId(num: Int) {
        self.id = num
    }
    
    func getId() -> Int {
        return self.id
    }
    
    
    func setDate() {
        let date = Date()
        self.workoutDate = date
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let thisDate = formatter.string(from: self.workoutDate)
        return thisDate
    }
    
    func getExactDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss:m"
        let thisDate = formatter.string(from: self.workoutDate)
        return thisDate
    }
    
    func getTotalSets() -> Double{
        return totalSets
    }
    func setTotalSets(listExercise: [Exercise2]) {
        var sets = 0.0
        for exercise in listExercise {
            sets += Double(exercise.getSetsOfExercises().count)
        }
        totalSets = sets
    }
    
    func setTotalReps(listExercise: [Exercise2]) {
        var reps = 0.0
        for exercise in listExercise {
            for set in exercise.getSetsOfExercises() {
                reps += set.getReps()
            }
        }
        totalReps = reps
    }
    
    func getTotalReps() -> Double {
        return totalReps
    }
    
    func setTotalWeight(listExercise: [Exercise2]) {
        var weight = 0.0
        for exercise in listExercise {
            var weightExercise = 0.0
            for set in exercise.getSetsOfExercises() {
                let weightSet = set.getReps() * set.getWeight()
                weightExercise += weightSet
            }
            weight += weightExercise
        }
        weightVolume = weight
    }
    func getTotalWeight() -> Double {
        print(weightVolume)
        return weightVolume
    }
    
    func getExercises() -> [Exercise2] {
        return exerciseList
    }
    func clearExercises() {
        exerciseList.removeAll()
    }
    
    func addNewExercise(name: String, reps: String, sets: String, weight: String, rest: String) {
        let theReps = removeCharsAndCommas(info: reps)
        let theSets = removeCharsAndCommas(info: sets)
        let theWeight = removeCharsAndCommas(info: weight)
        let theRest = removeCharsAndCommas(info: rest)
        let createdExercise = Exercise2(name: name)
        createdExercise.addSetOfExercise(reps: theReps, sets: theSets, weight: theWeight, rest: theRest)
        exerciseList.append(createdExercise)
        setTotalReps(listExercise: exerciseList)
        setTotalSets(listExercise: exerciseList)
        setTotalWeight(listExercise: exerciseList)
    }
    
    func addNewSet(name: String, reps: String, sets: String, weight: String, rest: String) {
        let theReps = removeCharsAndCommas(info: reps)
        let theSets = removeCharsAndCommas(info: sets)
        let theWeight = removeCharsAndCommas(info: weight)
        let theRest = removeCharsAndCommas(info: rest)
        let exercise = self.getSpecificExerciseByName(nameOfExercise: name)
        if (exercise.getName() != "NOOOOOO") {
            exercise.addSetOfExercise(reps: theReps, sets: theSets, weight: theWeight, rest: theRest)
        } else {
            print("No exercise should get created!!")
        }
    }
    
    func getSpecificExerciseByName(nameOfExercise: String) -> Exercise2 {
        for exercise in self.exerciseList {
            if (exercise.getName() == nameOfExercise) {
                return exercise
            }
        }
        return Exercise2(name: "NOOOOOO")
    }
    
    //Remove characters and replace commas with . and return a Double
    
    func removeCharsAndCommas(info: String) -> Double {
        var returnDouble: Double
        var createdText = ""
        var textArray = info.split(separator: ",")
        var counter = 0;
        
        
        
        if (textArray.count < 2) {
            textArray = info.split(separator: ".")
            for text in textArray {
                if (counter == 0) {
                    createdText += removeChars(texts: text) + "."
                } else {
                    createdText += removeChars(texts: text)
                }
                counter += 1
            }
        } else {
            for text in textArray {
                if (counter == 0) {
                    createdText += removeChars(texts: text) + "."
                } else {
                    createdText += removeChars(texts: text)
                }
                counter += 1
            }
        }
        if (isStringADouble(string: createdText)) {
            returnDouble = Double(createdText)!
        } else {
            returnDouble = 0.0
        }
        return returnDouble
    }
    
    func removeChars(texts: Substring) -> String{
        let characters = Array(texts)
        var number = ""
        for char in characters {
            if (isCharADouble(string: char)) {
                number.append(char)
            }
        }
        return number
    }
    
    func isStringADouble(string: String) -> Bool {
        return Double(string) != nil
    }
    func isCharADouble(string: Character) -> Bool {
        return Int(String(string)) != nil
    }
}
