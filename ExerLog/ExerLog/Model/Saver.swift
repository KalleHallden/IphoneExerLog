//
//  Saver.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-22.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

class Saver {
    
    private var pathWorkoutLog: String?
    private var pathTheme: String?
    private var pathPersonalStats: String?
    
    func getPathWorkout() -> String {
        let path = fileInDocumentsDirectory(filename: "/workoutLst.json")
        self.pathWorkoutLog = path
        return path
    }
    func getPathPersonal() -> String {
        let path = fileInDocumentsDirectory(filename: "/personal.json")
         self.pathPersonalStats = path
        return path
    }
    func getPathTheme() -> String {
        let path = fileInDocumentsDirectory(filename: "/theme.json")
        self.pathTheme = path
        return path
    }
    
    func getFileForWorkoutLog() -> String? {
        print(TabBarViewController.workoutLog.getWorkoutList().count)
        let encodedObject = try? JSONEncoder().encode(TabBarViewController.workoutLog)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            print(encodedObjectJsonString)
            return encodedObjectJsonString
        }
        return "nope"
    }
    
    func getFileForTheme() -> String? {
        print("Theme")
        let encodedObject = try? JSONEncoder().encode(TabBarViewController.theme)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            print(encodedObjectJsonString)
            return encodedObjectJsonString
        }
        return "nope"
    }
    
    func getFileForPersonalStats() -> String? {
        print("Personal")
        let encodedObject = try? JSONEncoder().encode(TabBarViewController.personalStats)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            print(encodedObjectJsonString)
            return encodedObjectJsonString
        }
        return "nope"
    }
    
    func load(pathWorkout: String, pathTheme: String, pathPersonalStats: String) {
        var workoutLog: WorkoutLog?
        var theme: Theme?
        var personalStats: PersonalStats?
        let jsondataWorkouts = find(path: pathWorkout)
        if let jasonDataWorkout = jsondataWorkouts.data(using: .utf8)
        {
            //And here you get the Car object back
            print("Här")
            workoutLog = try? JSONDecoder().decode(WorkoutLog.self, from: jasonDataWorkout)
        } else {
            print("Nej!")
            workoutLog = WorkoutLog()
        }
        TabBarViewController.workoutLog = workoutLog ?? TabBarViewController.workoutLog
        
        let jsondataTheme = find(path: pathTheme)
        if let jasonDataTheme = jsondataTheme.data(using: .utf8)
        {
            //And here you get the Car object back
            print("Här")
            theme = try? JSONDecoder().decode(Theme.self, from: jasonDataTheme)
        } else {
            print("Nej!")
            theme = Theme()
        }
        TabBarViewController.theme = theme ?? TabBarViewController.theme
        
        let jsondataPersonal = find(path: pathPersonalStats)
        if let jasonDataPersonal = jsondataPersonal.data(using: .utf8)
        {
            //And here you get the Car object back
            print("Här")
            personalStats = try? JSONDecoder().decode(PersonalStats.self, from: jasonDataPersonal)
        } else {
            print("Nej!")
            personalStats = PersonalStats()
        }
        TabBarViewController.personalStats = personalStats ?? TabBarViewController.personalStats
    }
    
    func documentstDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        return documentsFolderPath
    }
    func fileInDocumentsDirectory(filename: String) -> String {
        return documentstDirectory().appending(filename)
    }
    
    func deleteOldFile(path: String) {
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(atPath: path)
            print("YESSSS")
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func save(path: String) {
        print("Save \(path)")
        
        if (path == getPathWorkout()) {
            let filetosave = getFileForWorkoutLog()
            var success = false
            success = NSKeyedArchiver.archiveRootObject(filetosave, toFile: path)
            if (success) {
                print("Workout Saved successfully")
            } else {
                print("Not able to save")
            }
        } else if (path == getPathTheme()) {
            let filetosave = getFileForTheme()
            var success = false
            success = NSKeyedArchiver.archiveRootObject(filetosave, toFile: path)
            if (success) {
                print("Theme Saved successfully")
            } else {
                print("Not able to save")
            }
        } else if (path == getPathPersonal()) {
            let filetosave = getFileForPersonalStats()
            var success = false
            success = NSKeyedArchiver.archiveRootObject(filetosave, toFile: path)
            if (success) {
                print("Personal stats Saved successfully")
            } else {
                print("Not able to save")
            }
        }
    }
    
    func find(path: String) -> String {
        if let returnString = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? String  {
            print("Yes..")
            return returnString
        } else {
            return "no"
        }
    }
}

