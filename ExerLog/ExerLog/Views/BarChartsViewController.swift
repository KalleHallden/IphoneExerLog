//
//  BarChartsViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-15.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class BarChartsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {

    let cellId = "cellid"
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private var masterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    func autoLayoutConstraint() {
        setVolumeList()
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.backgroundColor = Colors.grey
        let master = setUpMasterStack()
        contentView.addSubview(master)
        master.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.1).isActive = true
        master.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        master.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        master.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    }
    let layout = UICollectionViewFlowLayout()
    func setUpMasterStack() -> UIStackView {

        let myCollectionView = UICollectionView(frame: scrollView.frame, collectionViewLayout: layout)
        myCollectionView.backgroundColor = UIColor.blue
        myCollectionView.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        (myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)? .scrollDirection = .horizontal
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        scrollView.addSubview(myCollectionView)
        myCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        myCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        myCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        myCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        
        masterStackView.addArrangedSubview(myCollectionView)
        //let addbutton = addButton()
        // addbutton.addTarget(self, action: #selector(action), for: .touchUpInside)
        //masterStackView.addArrangedSubview(addbutton)
        
        return masterStackView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return volumeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let thisHeight = view.frame.height
        //        let new = (thisHeight * 0.68)
        return CGSize(width: 30, height: thisHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        
        if let max = volumeList.max() {
            let value = volumeList[indexPath.item]
            let ratio = value / max
            cell.barHeightConstraint?.constant = CGFloat(view.frame.height) * ratio
        }
        return cell
    }
    
    var workoutLog = TabBarViewController.workoutLog
    var volumeList: [CGFloat] = []
    
    func setVolumeList() {
        let workouts = workoutLog.getWorkoutList()
        for workout in workouts {
            let vol = CGFloat(workout.getTotalWeight())
            print("This is vol \(vol)")
            volumeList.append(vol)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        autoLayoutConstraint()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
