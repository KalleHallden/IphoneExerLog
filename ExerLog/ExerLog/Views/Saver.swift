//
//  Saver.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-19.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation

class Saver: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(workoutLog, forKey: "log")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let log = aDecoder.decodeObject(forKey: "log") as? WorkoutLog else {
            print("didn't work")
            return nil
        }
        self.init(log: log)
    }
    
    init(log: WorkoutLog) {
        self.workoutLog = log
    }
    private var workoutLog: WorkoutLog!
    
}
