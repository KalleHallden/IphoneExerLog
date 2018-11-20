//
//  NavControllerBarChart.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-20.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class NavControllerBarChart: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        let newWorkout = BarChartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let tabBarList = [newWorkout]
        viewControllers = tabBarList
        self.navigationBar.barTintColor = .black
        
    }
    
}
