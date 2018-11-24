//
//  Workoutlog2.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-24.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation


class Workoutlog2 {
    
    private var workoutList = [Workout2]()
    
    func setUpWorkoutList(workoutList: [Workout2]) {
        self.workoutList = workoutList
    }
    
//    init(workoutLst:[Workout2]) {
//        self.workoutList = workoutLst
//    }
    
    func addNewWorkout(numberOfWorkouts: Int) {
        for num in 1...numberOfWorkouts {
            print("num of workouts: \(num)")
            let newWorkout = Workout2()
            self.workoutList.append(newWorkout)
        }
    }
    
    func removeWorkoutAt(index: Int) {
        self.workoutList.remove(at: index)
    }
    
    func addWorkout(workout: Workout2) {
        self.workoutList.append(workout)
    }
    
    func getWorkoutList() -> [Workout2] {
        return self.workoutList
    }
    
    func getSpecificWorkout(id: Int) -> Workout2 {
        let returnWorkout = self.workoutList[id]
        return returnWorkout
    }
    
    func getWorkoutIdByDate(date: String) -> Int {
        var count = 0
        for workout in workoutList {
            if (workout.getDate() == date) {
                return count
            }
            count += 1
        }
        return -1
    }
}


















