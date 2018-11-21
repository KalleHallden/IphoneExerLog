//
//  WorkoutLog.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

class WorkoutLog: NSObject, Codable {
    

    func encode(with aCoder: NSCoder) {
       aCoder.encode(workoutList, forKey: "workLst")
        aCoder.encode(theme, forKey: "thme")
    }

    required convenience init?(coder aDecoder: NSCoder) {
        guard let workList = aDecoder.decodeObject(forKey: "workLst") as? [Workout],
        let thme = aDecoder.decodeObject(forKey: "thme") as? Bool else {
            print("didn't work")
            return nil
        }
        self.init(workoutLst: workList, theme: thme)
    }

    
    func setUpWorkoutList(workoutList: [Workout]) {
        self.workoutList = workoutList
    }
    
    init(workoutLst:[Workout], theme: Bool) {
        self.workoutList = workoutLst
        self.theme = theme
    }
    override init() {}

    private var theme = false
    private var workoutList = [Workout]()

    func addNewWorkout(numberOfWorkouts: Int) {
        for num in 1...numberOfWorkouts {
            print("num of workouts: \(num)")
            let newWorkout = Workout()
            self.workoutList.append(newWorkout)
        }
    }
    
    func getTheme() -> Bool {
        return self.theme
    }
    
    func setTheme(themeHasBeenSet: Bool) {
        self.theme = themeHasBeenSet
    }
    
    func removeWorkoutAt(index: Int) {
        self.workoutList.remove(at: index)
    }
    
    func addWorkout(workout: Workout) {
            self.workoutList.append(workout)
    }
    
    func getWorkoutList() -> [Workout] {
        return self.workoutList
    }
    
    func getSpecificWorkout(id: Int) -> Workout {
        let returnWorkout = self.workoutList[id]
        return returnWorkout
    }
    
    func getWorkoutIdByDate(date: String) -> Int {
        for workout in workoutList {
            if (workout.getDate() == date) {
                return workoutList.index(of: workout)!
            }
        }
        return -1
    }
}



























