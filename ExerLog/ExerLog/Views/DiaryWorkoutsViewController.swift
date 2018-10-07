//
//  DiaryWorkoutsViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-07.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//


import UIKit

class DiaryWorkoutsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellid"
    var viewHeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewHeight = Int(view.frame.height) / 2
        builder()
        
        collectionView?.backgroundColor = .gray
        
        collectionView?.register(DiaryCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)? .scrollDirection = .vertical
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    // Amount of bars
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return volumeList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    var workoutLog = WorkoutLog()
    
    func builder() {
        workoutLog.addNewWorkout(numberOfWorkouts: 3)
        let workout3 = workoutLog.getSpecificWorkout(id: 2)
        let workout2 = workoutLog.getSpecificWorkout(id: 1)
        let workout1 = workoutLog.getSpecificWorkout(id: 0)
        
        workout1.addNewExercise(name: "Deadlift", reps: "500", sets: "5", weight: "122,5kg", rest: "120s")
        workout1.addNewExercise(name: "Squat", reps: "8", sets: "3", weight: "180kg", rest: "120s")
        workout1.addNewExercise(name: "Bench Press", reps: "12", sets: "3", weight: "80kg", rest: "120s")
        workout1.setTotalWeight(listExercise: workout1.getExercises())
        
        workout2.addNewExercise(name: "Deadlift", reps: "8", sets: "4", weight: "122,5kg", rest: "120s")
        workout2.addNewExercise(name: "Squat", reps: "10", sets: "5", weight: "180kg", rest: "120s")
        workout2.addNewExercise(name: "Bench Press", reps: "8", sets: "9", weight: "80kg", rest: "120s")
        workout2.setTotalWeight(listExercise: workout2.getExercises())
        
        workout3.addNewExercise(name: "Deadlift", reps: "4", sets: "4", weight: "122,5kg", rest: "120s")
        workout3.addNewExercise(name: "Squat", reps: "5", sets: "5", weight: "180kg", rest: "120s")
        workout3.addNewExercise(name: "Bench Press", reps: "3", sets: "5", weight: "80kg", rest: "120s")
        workout3.setTotalWeight(listExercise: workout3.getExercises())
        
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
        return CGSize(width: Int(view.frame.width), height: viewHeight)
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
