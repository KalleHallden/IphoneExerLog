//
//  NavControllerDiary.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-20.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class NavControllerDiary: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        let newWorkout = DiaryWorkoutsViewController()
        let tabBarList = [newWorkout]
        viewControllers = tabBarList

        
    }
    
}
