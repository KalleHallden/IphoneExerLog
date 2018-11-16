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
    
    // Height and Width of bars
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: view.frame.height * 0.78)
    }
    
    var backButton = UIButton()
//
    @objc func statAction(sender:UIButton!) {
        print(numOfPresses)
        self.collectionView?.reloadData()
        if (numOfPresses == 0) {
            sender.setTitle("Current view: Volume", for: .normal)
        } else if (numOfPresses == 1) {
            sender.setTitle("Current view: Load", for: .normal)
        } else {
            sender.setTitle("Current view: Sets", for: .normal)
        }
        //setValueList(num: numOfPresses)
    }
    
    func buttonBack() {
        
        if (numOfPresses == 0) {
            backButton.setTitle("Current view: Volume", for: .normal)
        } else if (numOfPresses == 1) {
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
