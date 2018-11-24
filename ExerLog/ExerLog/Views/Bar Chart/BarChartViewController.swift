//
//  BarChartViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-25.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

class BarChartViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    let cellId = "cellid"
    
    var values: [CGFloat] = []
    let saver = Saver()
    
    func leftButton() -> UIBarButtonItem {
        let button:UIBarButtonItem = {
            let btn = UIBarButtonItem()
            btn.title = "Whatsup"
            btn.tintColor = Colors.greens
            return btn
        }()
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonBack()
        
        collectionView?.backgroundColor = Colors.grey
        
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)? .scrollDirection = .horizontal
        
    }
    static var freshLaunch = true
    static var diaryLaunch = false
    
    func setFresh(hasbeenLaunched: Bool) {
        BarChartViewController.freshLaunch = hasbeenLaunched
    }
    func setDiaryLaunch(hasbeenLaunched: Bool) {
        BarChartViewController.diaryLaunch = hasbeenLaunched
    }
    
    var clicks = 0
    
    override func viewWillAppear(_ animated: Bool) {
        clicks = 0
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
        if BarChartViewController.freshLaunch == true {
            BarChartViewController.freshLaunch = false
            self.tabBarController?.selectedIndex = 1 // 5th tab
        }
        if (BarChartViewController.diaryLaunch == true) {
             BarChartViewController.diaryLaunch = false
            self.tabBarController?.selectedIndex = 3
        }
        self.viewDidLoad()
    }
    
    
    func setValueList(num: Int) {
        values.removeAll()
        let workoutList = TabBarViewController.workoutLog.getWorkoutList()
       // workoutList.reversed()
        if (num == 2) {
            for workout in workoutList {
                values.append(CGFloat(workout.getTotalReps()))
                print(workout.getTotalReps())
            }
        } else if (num == 1) {
            for workout in workoutList {
                values.append(CGFloat(workout.getTotalSets()))
                print(workout.getTotalSets())
            }
        } else {
            for workout in workoutList {
                values.append(CGFloat(workout.getTotalWeight()))
                print(workout.getTotalWeight())
            }
        }
        //values.reverse()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // Amount of bars
    static var numOfPresses = 0
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setValueList(num: getNumberOfClicks())
        return values.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        // cell.barHeightConstraint?.constant = values[indexPath.item]
        
        if (values.max() != 0) {
            if let max = values.max() {
                let value = values[indexPath.item]
                let ratio = value / max
                let height = (view.frame.height - 200) * ratio
                cell.barHeightConstraint?.constant = height
                cell.barHeightAnimation(viewHeight: Int(view.frame.height))
                cell.barHeightAnimation(viewHeight: Int(view.frame.height))

                
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath.item)")

        let cell = collectionView.cellForItem(at: indexPath) as? BarCell
        cell?.setBackgroundColor(hasBeenPressed: true)
        if (!(cell?.hasbeen)!) {
            print("Has been pressed")
        } else {
            barPresed(barNumber: indexPath.item)
        }
        //collectionView.reloadData()
    }    
    // Height and Width of bars
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: view.frame.height * 0.78)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    var backButton = UIButton()
//
    @objc func statAction(sender:UIButton!) {
        pressed()
        self.collectionView?.reloadData()
        if (getNumberOfClicks() == 0) {
            sender.setTitle("Current view: Load", for: .normal)
        } else if (getNumberOfClicks() == 1) {
            sender.setTitle("Current view: Sets", for: .normal)
        } else {
            sender.setTitle("Current view: Volume", for: .normal)
        }
        let colors = Colors()
        clicks += 1
        print("Clicks: \(clicks)" )
        if (clicks > 20 && clicks < 31) {
            if (TabBarViewController.theme.getTheme()) {
                TabBarViewController.theme.setTheme(themeHasBeenSet: false)
                print("Setting theme dark")
                saver.deleteOldFile(path: saver.getPathTheme())
                saver.save(path: saver.getFileForTheme()!)
                colors.setColors()
            } else {
                TabBarViewController.theme.setTheme(themeHasBeenSet: true)
                print("Setting theme light")
                saver.deleteOldFile(path: saver.getFileForTheme()!)
                saver.save(path: saver.getPathTheme())
                colors.setColors()
                
            }
            if (clicks == 30) {
                showAlertForThemeChange()
            }
        }
        //setValueList(num: numOfPresses)
    }
    
    func showAlertForThemeChange() {
        
        let message = "Do you want to change the theme?"
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // Style of the alert
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.darkGreen
        alert.view.tintColor = Colors.darkGrey
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("Should Change")
                if (TabBarViewController.theme.getSuperDark()) {
                    self.setWantsToChangeTheme(wantsToChanges: false)
                } else {
                    self.setWantsToChangeTheme(wantsToChanges: true)
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        alert.addAction(UIAlertAction(title: "Not now", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.setWantsToChangeTheme(wantsToChanges: false)
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private static var wantsTochange = false
    
    func getWantsToChangeTheme() -> Bool {
        print(BarChartViewController.wantsTochange)
        return BarChartViewController.wantsTochange
    }
    
    func setWantsToChangeTheme(wantsToChanges: Bool) {
        print("wants to change: \(wantsToChanges)")
        BarChartViewController.wantsTochange = wantsToChanges
        let colors = Colors()
        
        if (wantsToChanges) {
            print("Setting theme dark")
            colors.setTheme(isDark: true)
            saver.deleteOldFile(path: saver.getPathTheme())
            TabBarViewController.theme.setSuperDark(themeHasBeenSet: wantsToChanges)
            print("Trying to print theme should be dark: \(TabBarViewController.theme.getSuperDark())")
            saver.save(path: saver.getPathTheme())
            colors.setColors()
        } else {
            print("Setting theme no")
            colors.setTheme(isDark: false)
            saver.deleteOldFile(path: saver.getPathTheme())
            TabBarViewController.theme.setSuperDark(themeHasBeenSet: wantsToChanges)
            print("Trying to print theme should be dark: \(TabBarViewController.theme.getSuperDark())")
            saver.save(path: saver.getPathTheme())
            colors.setColors()
        }
    }
    
    func barPresed(barNumber: Int) {
        
        let workout = TabBarViewController.workoutLog.getSpecificWorkout(id: barNumber)
        print("These are the sets \(workout.getTotalSets())")
        var typeOfData: String
        if (getNumberOfClicks() == 0) {
            typeOfData = "\nLoad: \(workout.getTotalWeight())"
        } else if (getNumberOfClicks() == 1) {
            typeOfData = "\nSets: \(workout.getTotalSets())"
        } else {
            typeOfData = "\nVolume: \(workout.getTotalReps())"
        }
        
        let message = "Date: \(workout.getDate()) \(typeOfData)"
        let alert = UIAlertController(title: "Workout \(barNumber + 1)", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let attributedText = NSMutableAttributedString(string: message)
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "Avenir next", size: 20.0)!, range: range)


        
        // Style of the alert
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.darkGreen
        alert.view.tintColor = Colors.darkGrey
        
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.openThatWorkout(workoutnum: barNumber)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func pressed() {
        print("Current number of presses: \(BarChartViewController.numOfPresses)")
        if (BarChartViewController.numOfPresses == 0) {
            BarChartViewController.numOfPresses = 1
        } else if (BarChartViewController.numOfPresses == 1) {
            BarChartViewController.numOfPresses = 2
        } else if (BarChartViewController.numOfPresses == 2) {
            BarChartViewController.numOfPresses = 0
        }
    }
    
    func getNumberOfClicks() -> Int {
        return BarChartViewController.numOfPresses
    }
    
    func openThatWorkout(workoutnum: Int) {
        print("opening workout")
        print(TabBarViewController.workoutLog.getSpecificWorkout(id: workoutnum).getExactDate())
        let workouts = TabBarViewController.workoutLog.getSpecificWorkout(id: workoutnum)
        regSegue(workout1: workouts)
    }
    func regSegue(workout1: Workout){
        let page = NavigationPreviousWorkoutViewController()
        page.setWorkout(workout1: workout1)
        present(page, animated: true, completion: nil)
    }
    
    func buttonBack() {
        backButton.titleLabel?.font = UIFont(name: "Avenir next", size: 20)!
        if (getNumberOfClicks() == 1) {
            backButton.setTitle("Current view: Volume", for: .normal)
            print("We are here now")
        } else if (getNumberOfClicks() == 0) {
            backButton.setTitle("Current view: Load", for: .normal)
        } else {
            backButton.setTitle("Current view: Sets", for: .normal)
        }
        backButton.setTitleColor(Colors.grey, for: .normal)
        backButton.backgroundColor = Colors.greens
        backButton.frame = CGRect(x: view.frame.width / 2 - 150  , y: view.frame.height/9.5, width: 300, height: 36)
        view.addSubview(backButton)
        //backButton.layer.borderWidth = 2
        backButton.layer.cornerRadius = 0
        backButton.addTarget(self, action: #selector(statAction), for: .touchUpInside)
    }
}
