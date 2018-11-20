//
//  NavigationPreviousWorkoutViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-18.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class NavigationPreviousWorkoutViewController: UINavigationController {
    private static var workout: Workout!
    
    func setWorkout(workout1: Workout) {
        print("This is the exercises: \(workout1.getExercises().count)")
        NavigationPreviousWorkoutViewController.workout = workout1
    }
    
    func getWorkout() -> Workout {
        return NavigationPreviousWorkoutViewController.workout
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
    
        
        func setup() {
            let previousWorkout = PreviousWorkoutViewController()
            previousWorkout.setWorkout(workout1: getWorkout())
            let tabBarList = [previousWorkout]
            viewControllers = tabBarList
            
            
        }
        
}
