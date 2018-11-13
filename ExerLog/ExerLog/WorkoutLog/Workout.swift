//
//  Workout.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Workout: NSObject {
    
    private var weightVolume: Double = 0.0
    private var totalSets: Double = 0
    private var totalReps: Double = 0
    private var exerciseList = [Exercise]()
    
    func getTotalSets() -> Double{
        return totalSets
    }
    func setTotalSets(listExercise: [Exercise]) {
        var sets = 0.0
        for exercise in listExercise {
            sets += exercise.getSets()
        }
        totalSets = sets
    }
    
    func setTotalReps(listExercise: [Exercise]) {
        var reps = 0.0
        for exercise in listExercise {
            let counter = exercise.getReps() * exercise.getSets()
            reps = reps + counter
        }
        totalReps = reps
    }
    
    func getTotalReps() -> Double {
        return totalReps
    }
    
    func setTotalWeight(listExercise: [Exercise]) {
        var weight = 0.0
        for exercise in listExercise {
            let counter = exercise.getReps() * exercise.getSets()
            let weights = exercise.getWeight()
            
            weight = weight + (counter * weights)
        }
        weightVolume = weight
    }
    func getTotalWeight() -> Double {
        print(weightVolume)
        return weightVolume
    }
    
    func getExercises() -> [Exercise] {
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
        let createdExercise = Exercise(names: name, repss: theReps, setss: theSets, weights: theWeight, rests: theRest)
        setTotalReps(listExercise: exerciseList)
        setTotalSets(listExercise: exerciseList)
        setTotalWeight(listExercise: exerciseList)
        exerciseList.append(createdExercise)
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
















