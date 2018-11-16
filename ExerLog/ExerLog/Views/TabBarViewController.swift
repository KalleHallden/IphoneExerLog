//
//  TabBarViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-10.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    public static let workoutLog = WorkoutLog()
    let statImage = #imageLiteral(resourceName: "statIcon")
    let addImage = #imageLiteral(resourceName: "addIcon")
    let diaryImage = #imageLiteral(resourceName: "diaryIcon")
    let weightImage = #imageLiteral(resourceName: "weightIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        
//        
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
        
        let statViewController = BarChartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let diaryViewController = DiaryWorkoutsViewController()
        let addWorkoutViewController = AddWorkoutViewController()
        let weightDiaryViewController = WeightDiaryViewController()
        let profileViewController = ProfileViewController()
        
        statViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        addWorkoutViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        weightDiaryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 4)
        
        //let tabBarList = [statViewController, profileViewController, addWorkoutViewController, diaryViewController, weightDiaryViewController]
        
        let tabBarList = [statViewController, addWorkoutViewController, diaryViewController]
        
        
        viewControllers = tabBarList
        self.tabBar.barTintColor = Colors.blacks
        self.tabBar.unselectedItemTintColor = Colors.greens
        //self.tabBarItem.image = UIImage.init(cgImage: #imageLiteral(resourceName: "statIcon"))
        statViewController.tabBarItem = UITabBarItem.init(title: nil, image: statImage, tag: 0)
        addWorkoutViewController.tabBarItem = UITabBarItem.init(title: nil, image: addImage, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem.init(title: nil, image: diaryImage, tag: 3)
        weightDiaryViewController.tabBarItem = UITabBarItem.init(title: nil, image: weightImage, tag: 4)
        

    }

}
