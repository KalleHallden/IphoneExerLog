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
        let lBtn = leftButton()
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = lBtn
        self.navigationController?.navigationItem.setRightBarButton(lBtn, animated: true)
//        let rightButton = UIBarButtonItem()
//        rightButton.title = ""
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
        // Do any additional setup after loading the view, typically from a nib.
        buttonBack()
        
        collectionView?.backgroundColor = Colors.grey
        
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)? .scrollDirection = .horizontal
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
    }
    
    func setValueList(num: Int) {
        values.removeAll()
        let workoutList = TabBarViewController.workoutLog.getWorkoutList()
        if (num == 0) {
            for workout in workoutList {
                values.append(CGFloat(workout.getTotalReps()))
                print(workout.getTotalReps())
            }
             numOfPresses += 1
        } else if (num == 1) {
            for workout in workoutList {
                values.append(CGFloat(workout.getTotalWeight()))
                print(workout.getTotalWeight())
            }
            numOfPresses += 1
        } else {
            for workout in workoutList {
                values.append(CGFloat(workout.getTotalSets()))
                print(workout.getTotalSets())
            }
            numOfPresses = 0
        }
        
//        if (values.count == 0) {
//            values = [1, 3, 5, 6, 10, 4, 23, 3, 6]
//        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // Amount of bars
    var numOfPresses = 0
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setValueList(num: numOfPresses)
        return values.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        // cell.barHeightConstraint?.constant = values[indexPath.item]
        if (values.max() != 0) {
            if let max = values.max() {
                let value = values[indexPath.item]
                let ratio = value / max
                cell.barHeightConstraint?.constant = (view.frame.height - 200) * ratio
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath.item)")
        barPresed(barNumber: indexPath.item)
        
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
        print(numOfPresses)
        self.collectionView?.reloadData()
        if (numOfPresses == 0) {
            sender.setTitle("Current view: Load", for: .normal)
        } else if (numOfPresses == 1) {
            sender.setTitle("Current view: Sets", for: .normal)
        } else {
            sender.setTitle("Current view: Volume", for: .normal)
        }
        //setValueList(num: numOfPresses)
    }
    
    func barPresed(barNumber: Int) {
        let workout = TabBarViewController.workoutLog.getSpecificWorkout(id: barNumber)
        var typeOfData: String
        if (numOfPresses == 0) {
            typeOfData = "\nLoad: \(workout.getTotalWeight())"
        } else if (numOfPresses == 1) {
            typeOfData = "\nSets: \(workout.getTotalSets())"
        } else {
            typeOfData = "\nVolume: \(workout.getTotalReps())"
        }
        
        let message = "Workout number \(barNumber + 1) \nDate: \(workout.getDate()) \(typeOfData)"
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
    // Style of the alert
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.darkGreen
        alert.view.tintColor = Colors.darkGrey
        //alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor : Colors.darkGrey]), forKey: "attributedTitle")
        
        
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
    
    
    func openThatWorkout(workoutnum: Int) {
        print("opening workout")
        print(TabBarViewController.workoutLog.getSpecificWorkout(id: workoutnum).getExactDate())
    }
    
    func buttonBack() {
        backButton.setTitle("Current view: Volume", for: .normal)
        backButton.setTitleColor(Colors.grey, for: .normal)
        backButton.backgroundColor = Colors.greens
        backButton.frame = CGRect(x: view.frame.width / 2 - 150  , y: view.frame.height/9.5, width: 300, height: 36)
        view.addSubview(backButton)
        //backButton.layer.borderWidth = 2
        backButton.layer.cornerRadius = 0
        backButton.addTarget(self, action: #selector(statAction), for: .touchUpInside)
    }
}
