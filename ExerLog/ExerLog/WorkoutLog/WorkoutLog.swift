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

    func addNewWorkout() {
        let newWorkout = Workout()
        workoutList.append(newWorkout)
    }
    func getWorkoutList() -> [Workout] {
        return workoutList
    }
    
    func getSpecificWorkout(id: Int) -> Workout {
        let returnWorkout = workoutList[id]
        return returnWorkout
    }
}



























