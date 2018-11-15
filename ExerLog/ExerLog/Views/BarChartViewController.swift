//
//  BarChartViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-25.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import Foundation
import UIKit

class BarChartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellid"
    var viewHeight: Int = 0
    var myCollectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewHeight = Int(view.frame.height) / 2
        builder()
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.backgroundColor = Colors.grey
        myCollectionView?.register(DiaryCell.self, forCellWithReuseIdentifier: cellId)
        (myCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout)? .scrollDirection = .vertical
        self.view.addSubview(myCollectionView)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    // Amount of bars
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return volumeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiaryCell
        
        
        //        if let max = volumeList.max() {
        //            let value = volumeList[indexPath.item]
        //            let ratio = value / max
        //            cell.barHeightConstraint?.constant = CGFloat(viewHeight) * ratio
        //
        //
        //        }
        
        
        return cell
        
    }
    let workoutLog = TabBarViewController.workoutLog
    
    func builder() {
        setVolumeList()
    }
    
    
    
    var volumeList: [CGFloat] = []
    
    func setVolumeList() {
        let workouts = workoutLog.getWorkoutList()
        for workout in workouts {
            let vol = CGFloat(workout.getTotalWeight())
            volumeList.append(vol)
        }
    }
    
    // Height and Width of bars
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let thisHeight = view.frame.height
        let new = (thisHeight * 0.68)
        
        return CGSize(width: 30, height: new)
    }
    
    var backButton = UIButton()
    
    func buttonBack() {
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.backgroundColor = UIColor.white
        backButton.frame = CGRect(x: view.frame.width/2-50 , y: view.frame.height/8, width: 100, height: 36)
        view.addSubview(backButton)
        
        backButton.layer.borderWidth = 2
        backButton.layer.cornerRadius = 18
        
        
        
        
    }
    
    
}
