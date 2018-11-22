//
//  colors.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-25.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

class Colors: UIColor {
    static var grey: UIColor?
    static var greens: UIColor?
    static var whites: UIColor?
    static var blacks: UIColor?
    static var darkGrey: UIColor?
    static var darkGreen: UIColor?
    static var lightBlue: UIColor?
    
    private static var blackTheme = TabBarViewController.workoutLog.getSuperDark()
    
    func isDarkTheme() -> Bool{
        return Colors.blackTheme
    }
    
    func setTheme(isDark: Bool) {
        Colors.blackTheme = isDark
    }
    func setColors() {
        Colors.blackTheme = TabBarViewController.workoutLog.getSuperDark()
        
        if (Colors.blackTheme) {
                print("Finally")
                Colors.grey = .black
                Colors.greens = .white
                Colors.whites = UIColor.white
                Colors.blacks = UIColor.white
                Colors.darkGrey = .black
                Colors.darkGreen = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.0)
        } else {
            if (TabBarViewController.workoutLog.getTheme()) {
                print("Light theme")
                Colors.grey = UIColor.white
                Colors.whites = UIColor.black
                Colors.greens = UIColor(red:0.04, green:0.50, blue:0.99, alpha:1.0)
                Colors.darkGrey = UIColor.white
                Colors.blacks = UIColor.white
                Colors.darkGreen = UIColor(red:0.16, green:0.36, blue:1.00, alpha:1.0)
                Colors.lightBlue = UIColor(red:0.59, green:0.93, blue:0.99, alpha:1.0)
                
            } else {
                print("Dark theme")
                Colors.grey = UIColor(red:0.16, green:0.16, blue:0.18, alpha:1.0)
                Colors.greens = UIColor(red:0.00, green:0.75, blue:0.10, alpha:1.0)
                Colors.whites = UIColor.white
                Colors.blacks = UIColor.black
                Colors.darkGrey = UIColor(red:0.04, green:0.04, blue:0.04, alpha:1.0)
                Colors.darkGreen = UIColor(red:0.01, green:0.33, blue:0.09, alpha:1.0)
            }
        }
    }
}


