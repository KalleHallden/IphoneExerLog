//
//  DiaryWorkoutsViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-10-07.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//


import UIKit

class DiaryWorkoutsViewController: UIViewController{
    
    var workout = Workout()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()
    private var rows = [[UIButton]]()
    
    private let viewScroller: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
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
    
    private var rowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.heightAnchor.constraint(equalToConstant: 250).isActive = true
//        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    func statButton(date: String) -> UIButton {
        let button:UIButton = {
            let btn = UIButton(type:.system)
            btn.backgroundColor = Colors.greens
            btn.setTitle(date, for: .normal)
            btn.tintColor = Colors.grey
            btn.layer.cornerRadius = 0
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        return button
    }
    private var statButt = UIButton()
    
    
    
    func getButton() -> UIButton {
        return statButt
    }
    
    func autoLayoutConstraint() {
        print("Yes 2")
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        //contentView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
       contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        contentView.backgroundColor = Colors.grey
        let master = setUpMasterStack()
        master.backgroundColor = .red
        contentView.addSubview(master)
        master.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.12).isActive = true
        master.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        master.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        master.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    }
    
    func setUpMasterStack() -> UIStackView {
        print("Yes 3")
        var numWorkouts = 0
        for workout in TabBarViewController.workoutLog.getWorkoutList() {
            print("Added one yo")
            let row = createRowOfWorkout(date: workout.getDate())
            if (numWorkouts != TabBarViewController.workoutLog.getWorkoutList().count) {
                rowStack.addArrangedSubview(row)
            }
            numWorkouts += 1
        }
        
        scrollView.addSubview(rowStack)
        rowStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        rowStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        rowStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        rowStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        rowStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        rowStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        rowStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        scrollView.isScrollEnabled = true
        masterStackView.addArrangedSubview(scrollView)
        return masterStackView
    }
    func setupStackViewHorizontal(stackview: UIStackView) {
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpTextFields(textField: UITextField) {
        textField.backgroundColor = Colors.greens
        textField.borderStyle = .none
        textField.textColor = Colors.grey
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startWorkout() {
        print("Yes 1")
        autoLayoutConstraint()
    }
    
    func createRowOfWorkout(date: String) -> UIStackView {
        let widthRow = (view.frame.width - 100)
        let stackview = UIStackView()
        var rowArray = [UIButton]()
        setupStackViewHorizontal(stackview: stackview)
        print("yes 4")
        let button = statButton(date: date)
        button.setTitle(date, for: .normal)
        button.widthAnchor.constraint(equalToConstant: widthRow)
        rowArray.append(button)
        button.addTarget(self, action: #selector(statAction), for: .touchUpInside)
        stackview.addArrangedSubview(button)
        print(stackview.arrangedSubviews.count)
        rows.append(rowArray)
        return stackview
    }
    // Actions
    var clickcount = 0
    
    @objc func statAction(sender:UIButton!) {
        let id = TabBarViewController.workoutLog.getWorkoutIdByDate(date: (sender.titleLabel?.text)!)
        if (id != -1) {
            print("This is the current workout date: \(TabBarViewController.workoutLog.getSpecificWorkout(id: id).getDate())")
            print(TabBarViewController.workoutLog.getWorkoutIdByDate(date: (sender.titleLabel?.text)!))
        }
    }
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        startWorkout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
