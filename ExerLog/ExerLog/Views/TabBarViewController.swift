//
//  TabBarViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-10.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    public static var workoutLog = WorkoutLog()
    public static var theme = Theme()
    public static var personalStats = PersonalStats()
    let statImage = #imageLiteral(resourceName: "statIcon")
    let addImage = #imageLiteral(resourceName: "addIcon")
    let diaryImage = #imageLiteral(resourceName: "diaryIcon")
    let weightImage = #imageLiteral(resourceName: "weightIcon")
    let saver = Saver()
    
    let log: WorkoutLog = TabBarViewController.workoutLog
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        saver.load(pathWorkout: saver.getPathWorkout(), pathTheme: saver.getPathTheme(), pathPersonalStats: saver.getPathPersonal())
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
//        doIt()
    }

    func setup() {
        
        let statViewController = BarChartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let diaryViewController = DiaryWorkoutsViewController()
        let addWorkoutViewController = AddWorkoutViewController()
        
        statViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        addWorkoutViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        
        //let tabBarList = [statViewController, profileViewController, addWorkoutViewController, diaryViewController, weightDiaryViewController]
        
        let tabBarList = [statViewController, addWorkoutViewController, diaryViewController]
        let colors = Colors()
        
        viewControllers = tabBarList
        if (colors.isDarkTheme()) {
            let backgroundclear = UIColor.clear.imageRepresentation
            self.tabBar.backgroundImage = backgroundclear
            self.tabBar.unselectedItemTintColor = .white
        } else {
            self.tabBar.barTintColor = Colors.blacks
            if (TabBarViewController.theme.getTheme()) {
                self.tabBar.unselectedItemTintColor = Colors.darkGreen
            } else {
                self.tabBar.unselectedItemTintColor = Colors.greens
            }
        }
        
        
        //self.tabBarItem.image = UIImage.init(cgImage: #imageLiteral(resourceName: "statIcon"))
        statViewController.tabBarItem = UITabBarItem.init(title: nil, image: statImage, tag: 0)
        addWorkoutViewController.tabBarItem = UITabBarItem.init(title: nil, image: addImage, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem.init(title: nil, image: diaryImage, tag: 3)
        

    }
    func setWorkoutList(log: WorkoutLog) {
        TabBarViewController.workoutLog = log
    }
}

