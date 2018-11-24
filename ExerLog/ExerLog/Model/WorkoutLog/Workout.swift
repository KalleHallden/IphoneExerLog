//
//  Workout.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Workout: NSObject, Codable {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(totalReps, forKey: "totReps")
        aCoder.encode(totalSets, forKey: "totSets")
        aCoder.encode(weightVolume, forKey: "weightVol")
        aCoder.encodeConditionalObject(exerciseList, forKey: "exerciseLst")
        aCoder.encodeConditionalObject(workoutDate, forKey: "date")
        aCoder.encode(id, forKey: "theId")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let weightVol = aDecoder.decodeObject(forKey: "weightVol") as? Double,
        let totSets = aDecoder.decodeObject(forKey: "totSets") as? Double,
        let totReps = aDecoder.decodeObject(forKey: "totReps") as? Double,
        let exerciseLst = aDecoder.decodeObject(forKey: "exerciseLst") as? [Exercise],
        let date = aDecoder.decodeObject(forKey: "date") as? Date,
        let theId = aDecoder.decodeObject(forKey: "theId") as? Int else {
            return nil
        }
        self.init(weightVol: weightVol, totReps: totReps, totSets: totSets, exerciseLst: exerciseLst, theDate: date, theID: theId)
    }
    
    init(weightVol:Double, totReps:Double, totSets: Double, exerciseLst: [Exercise], theDate: Date, theID: Int ) {
        self.weightVolume = weightVol
        self.totalSets = totSets
        self.totalReps = totReps
        self.exerciseList = exerciseLst
        self.workoutDate = theDate
        self.id = theID
    }
    
    override init() { }
    
    
    private var weightVolume: Double = 0.0
    private var totalSets: Double = 0
    private var totalReps: Double = 0
    private var exerciseList = [Exercise]()
    private var workoutDate = Date()
    private var id = -1
    
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
        exerciseList.append(createdExercise)
        setTotalReps(listExercise: exerciseList)
        setTotalSets(listExercise: exerciseList)
        setTotalWeight(listExercise: exerciseList)
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
















