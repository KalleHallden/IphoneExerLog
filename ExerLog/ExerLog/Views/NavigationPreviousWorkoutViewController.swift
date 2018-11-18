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
            
            
            //        TabBarViewController.workoutLog.addNewWorkout(numberOfWorkouts: 2)
            //        let workout1 = TabBarViewController.workoutLog.getSpecificWorkout(id: 0)
            //        let workout2 = TabBarViewController.workoutLog.getSpecificWorkout(id: 1)
            //
            //        workout1.addNewExercise(name: "Bench", reps: "10", sets: "10", weight: "100", rest: "60")
            //        workout1.addNewExercise(name: "squat", reps: "5", sets: "3", weight: "150", rest: "60")
            //
            //        workout2.addNewExercise(name: "Bench", reps: "4", sets: "4", weight: "100", rest: "60")
            //        workout2.addNewExercise(name: "squat", reps: "5", sets: "7", weight: "150", rest: "60")
            
            
            
            
            
            // Do any additional setup after loading the view.
        }
    
        
        func setup() {
            let previousWorkout = PreviousWorkoutViewController()
            previousWorkout.setWorkout(workout1: getWorkout())
            
            //let tabBarList = [statViewController, profileViewController, addWorkoutViewController, diaryViewController, weightDiaryViewController]
            
            let tabBarList = [previousWorkout]
            
            
            viewControllers = tabBarList
            //self.tabBarItem.image = UIImage.init(cgImage: #imageLiteral(resourceName: "statIcon"))
            
            
        }
        
}
