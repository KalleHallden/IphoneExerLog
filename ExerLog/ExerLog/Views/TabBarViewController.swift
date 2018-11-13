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
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        
        let statViewController = BarChartViewController()
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
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.unselectedItemTintColor = Colors.greens
        //self.tabBarItem.image = UIImage.init(cgImage: #imageLiteral(resourceName: "statIcon"))
        statViewController.tabBarItem = UITabBarItem.init(title: nil, image: statImage, tag: 0)
        addWorkoutViewController.tabBarItem = UITabBarItem.init(title: nil, image: addImage, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem.init(title: nil, image: diaryImage, tag: 3)
        weightDiaryViewController.tabBarItem = UITabBarItem.init(title: nil, image: weightImage, tag: 4)
        

    }

}
