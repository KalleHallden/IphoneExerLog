//
//  WorkoutLog.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class WorkoutLog: NSObject {
    private var workoutList = [Workout]()

    func addNewWorkout(numberOfWorkouts: Int) {
        for num in 1...numberOfWorkouts {
            print("num of workouts: \(num)")
            let newWorkout = Workout()
            self.workoutList.append(newWorkout)
        }
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



























