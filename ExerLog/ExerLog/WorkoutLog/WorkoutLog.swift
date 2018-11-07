//
//  WorkoutLog.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-06.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class WorkoutLog: NSObject {
    private static var workoutList = [Workout]()

    func addNewWorkout(numberOfWorkouts: Int) {
        var count = 0
        for _ in 0...numberOfWorkouts {
            print(count)
            let newWorkout = Workout()
            WorkoutLog.workoutList.append(newWorkout)
            count += 1
        }
    }
    func getWorkoutList() -> [Workout] {
        return WorkoutLog.workoutList
    }
    
    func getSpecificWorkout(id: Int) -> Workout {
        let returnWorkout = WorkoutLog.workoutList[id]
        return returnWorkout
    }
}



























