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
    let statImage = #imageLiteral(resourceName: "statIcon")
    let addImage = #imageLiteral(resourceName: "addIcon")
    let diaryImage = #imageLiteral(resourceName: "diaryIcon")
    let weightImage = #imageLiteral(resourceName: "weightIcon")
    var path: String = ""
    
    let log: WorkoutLog = TabBarViewController.workoutLog
    
    override func viewDidLoad() {
        super.viewDidLoad()
        path = fileInDocumentsDirectory(filename: "/workoutLst.json")
        setup()
        load()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
//        doIt()
    }
    
//    func doIt() {
//        guard let navigation = navigationController,
//            !(navigation.topViewController === self) else {
//                return
//        }
//        let bar = navigation.navigationBar
//        bar.setNeedsLayout()
//        bar.layoutIfNeeded()
//        bar.setNeedsDisplay()
//    }
    
    func setup() {
        
        let statViewController = BarChartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let diaryViewController = DiaryWorkoutsViewController()
        let addWorkoutViewController = AddWorkoutViewController()
        
        statViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        addWorkoutViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        
        //let tabBarList = [statViewController, profileViewController, addWorkoutViewController, diaryViewController, weightDiaryViewController]
        
        let tabBarList = [statViewController, addWorkoutViewController, diaryViewController]
        
        
        viewControllers = tabBarList
        self.tabBar.barTintColor = Colors.blacks
        self.tabBar.unselectedItemTintColor = Colors.greens
        
        
        //self.tabBarItem.image = UIImage.init(cgImage: #imageLiteral(resourceName: "statIcon"))
        statViewController.tabBarItem = UITabBarItem.init(title: nil, image: statImage, tag: 0)
        addWorkoutViewController.tabBarItem = UITabBarItem.init(title: nil, image: addImage, tag: 2)
        diaryViewController.tabBarItem = UITabBarItem.init(title: nil, image: diaryImage, tag: 3)
        

    }
    
    
    func setWorkoutList(log: WorkoutLog) {
        TabBarViewController.workoutLog = log
    }
    
    func getFile() -> String? {
        print(TabBarViewController.workoutLog.getWorkoutList().count)
        let encodedObject = try? JSONEncoder().encode(TabBarViewController.workoutLog)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            print(encodedObjectJsonString)
            return encodedObjectJsonString
        }
        return "nope"
    }
    
    func load() {
        var workoutLog: WorkoutLog?
        let jsondata = find()
        if let jsonData = jsondata.data(using: .utf8)
        {
            //And here you get the Car object back
            print("Här")
            workoutLog = try? JSONDecoder().decode(WorkoutLog.self, from: jsonData)
        } else {
            print("Nej!")
            workoutLog = WorkoutLog()
        }
        TabBarViewController.workoutLog = workoutLog ?? TabBarViewController.workoutLog
    }

    func documentstDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        return documentsFolderPath
    }
    func fileInDocumentsDirectory(filename: String) -> String {
        return documentstDirectory().appending(filename)
    }

    func deleteOldFile() {
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(atPath: path)
            print("YESSSS")
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func saveMe() {
        print("Save \(path)")
        
        
        
        let filetosave = getFile()
        
        
            var success = false
            success = NSKeyedArchiver.archiveRootObject(filetosave, toFile: path)
            if (success) {
                print("Saved successfully")
            } else {
                print("Not able to save")
            }
    }

    func find() -> String {
        if let returnString = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? String  {
            print("Yes..")
            return returnString
        } else {
            return "no"
        }
    }
    
    
}

