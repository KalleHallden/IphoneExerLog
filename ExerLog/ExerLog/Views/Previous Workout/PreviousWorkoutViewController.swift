//
//  PreviousWorkoutViewController.swift
//  ExerLog
//
//  Created by kalle hålldén on 2018-11-18.
//  Copyright © 2018 kalle hålldén. All rights reserved.
//

import UIKit

class PreviousWorkoutViewController: UIViewController {

    private static var workout: Workout2!
    let saver = Saver()
    var rowsOfSets = [[UITextField]]()
    var arrayOfExerciseNames = [String]()
    var howManySetsArray = [Int]()
    var numSets = 0
    
    var rowCount = 0
    var exerciseCount = 0
    var setCount = 0
    
    func setWorkout(workout1: Workout2) {
        print("This is the exercises: \(workout1.getExercises().count)")
        PreviousWorkoutViewController.workout = workout1
    }
    
    func getWorkout() -> Workout2 {
        return PreviousWorkoutViewController.workout
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view
    }()
    private var rows = [[UITextField]]()
    
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
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.heightAnchor.constraint(equalToConstant: 250).isActive = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    func statButton() -> UIButton {
        let button:UIButton = {
            let btn = UIButton(type:.system)
            btn.backgroundColor = Colors.greens
            btn.setTitle("Total Volume: 0.0", for: .normal)
            btn.tintColor = Colors.grey
            btn.layer.cornerRadius = 0
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        return button
    }
    private var statButt = UIButton()
    
    private func setStatBut() {
        self.statButt = statButton()
    }
    
    func getButton() -> UIButton {
        return statButt
    }
    
    func autoLayoutConstraint() {
        contentView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        contentView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.backgroundColor = Colors.grey
        let master = setUpMasterStack()
        contentView.addSubview(master)
        master.topAnchor.constraint(equalTo: contentView.topAnchor, constant: view.frame.height * 0.12).isActive = true
        master.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        master.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        master.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    }

    
    func addButton() -> UIButton {
        let button:UIButton = {
            let btn = UIButton(type:.system)
            if (TabBarViewController.theme.getTheme()) {
                btn.backgroundColor = Colors.grey
                btn.tintColor = Colors.greens
            } else {
                btn.backgroundColor = Colors.grey
                btn.tintColor = Colors.greens
            }
            btn.layer.cornerRadius = 15
            btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        return button
    }
    
    func barButton() -> UIBarButtonItem {
        let button:UIBarButtonItem = {
            let btn = UIBarButtonItem()
            btn.tintColor = Colors.greens
            btn.target = self
            return btn
        }()
        return button
    }
    
    private var topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func topRow() -> UIStackView {
        let filler = addButton()
        filler.backgroundColor = Colors.greens
        
        let stack = topStack
        let add = addButton()
        
        let save = barButton()
        let delete = barButton()
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = save
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = delete
        //add.setBackgroundImage(#imageLiteral(resourceName: "addIcon12"), for: .normal)
        add.setImage(#imageLiteral(resourceName: "addIcon12"), for: .normal)
//        add.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50.0)
        add.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        save.title = "Done"
        save.action = #selector(self.saveAction)
        delete.title = "Delete"
        delete.action = #selector(self.deleteAction)
    
        stack.addArrangedSubview(add)
        
        return stack
    }
    
    func setUpMasterStack() -> UIStackView {
        
        setStatBut()
        let statbutton = getButton()
        statbutton.titleLabel?.font = UIFont(name: "Avenir next", size: 20.0)!
        statbutton.addTarget(self, action: #selector(statAction), for: .touchUpInside)
        
        let top = topRow()
        masterStackView.addArrangedSubview(statbutton)
        
        let labelRow = createRowOfLabels()
        masterStackView.addArrangedSubview(labelRow)
        
        print("This is how many exercises: \(getWorkout().getExercises().count)")
        for exercise in getWorkout().getExercises() {
            print("\nRun")
            setUpRowOfTextFields(exercise: exercise, firstTime: true)
            if (exerciseCount < getWorkout().getExercises().count - 1) {
                setHowManySets(index: exerciseCount)
                numSets = 1
            }
            exerciseCount += 1
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
        masterStackView.addArrangedSubview(top)
        //let addbutton = addButton()
        // addbutton.addTarget(self, action: #selector(action), for: .touchUpInside)
        //masterStackView.addArrangedSubview(addbutton)
        
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
        let colors = Colors()
        textField.backgroundColor = Colors.grey
        
        textField.setBottomBorder(isDark: colors.isDarkTheme(), lineColor: Colors.greens!)
        //textField.borderStyle = .none
        textField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        textField.textColor = Colors.greens
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpRowOfTextFields(exercise: Exercise2, firstTime: Bool) {
        let widtdthTextField = (view.frame.width - 100) / 5
        var textFieldArray = [UITextField]()
        var setFieldArray = [UITextField]()
        
        var first = true
        print("\nExercise Sets: \(exercise.getSetsOfExercises().count)\n")
        for set in exercise.getSetsOfExercises() {
            let stackview = UIStackView()
            let stackview2 = UIStackView()
            let stackview3 = UIStackView()
            let label = UILabel()
            print("Ran")
            if (first) {
                label.textColor = Colors.greens
                label.font = UIFont(name: "Avenir next", size: 16)!
                label.text = exercise.getName()
                if (firstTime) {
                    arrayOfExerciseNames.append(exercise.getName())
                }
                first = false
            } else {
                label.text = " "
            }

            print(label.text)
            for num in 1...4 {
                let textField = textfieldMaker()
                textField.textAlignment = .center
                
                if (num < 3) {
                    stackview2.addArrangedSubview(textField)
                    if (num == 1) {
                        textField.text = String(set.getReps())
                    } else if (num == 2) {
                        textField.text = String(set.getSetNum())
                    }
                } else {
                    stackview3.addArrangedSubview(textField)
                    if (num == 3) {
                        textField.text = String(set.getWeight())
                    } else if (num == 4) {
                        textField.text = String(set.getRest())
                    }
                }
                textFieldArray.append(textField)
                textField.widthAnchor.constraint(equalToConstant: widtdthTextField)
        }
        
        setupStackViewHorizontal(stackview: stackview2)
        setupStackViewHorizontal(stackview: stackview3)
        setupStackViewHorizontal(stackview: stackview)
        
        stackview.addArrangedSubview(label)
        stackview.addArrangedSubview(stackview2)
        stackview.addArrangedSubview(stackview3)
        rowStack.addArrangedSubview(stackview)
        print("Stack: \(rowStack.arrangedSubviews.count)")
        rows.append(textFieldArray)
        rowsOfSets.append(setFieldArray)
    }
  }
    
    func startWorkout() {
        for row in rowStack.arrangedSubviews {
            rowStack.removeArrangedSubview(row)
            row.removeFromSuperview()
        }
        rows.removeAll()
        autoLayoutConstraint()
    }
    
    
    func addNewExercise(exerciseNum: Int) {
        getWorkout().clearExercises()
        print("Exercise: \(arrayOfExerciseNames[exerciseNum - 1])")
        for array in rows {
            getWorkout().addNewExercise(name: arrayOfExerciseNames[exerciseNum - 1], reps: array[0].text!, sets: array[1].text!, weight: array[2].text!, rest: array[3].text!)
        }
        print(getWorkout().getExercises().count)
        print(getWorkout().getTotalReps())
    }
        
    func addNewSet() {
        print("This is exercount: \(exerciseCount)")
        print("This is namesarray: \(arrayOfExerciseNames.count)")
        let exerciseList = getWorkout().getExercises()
        let thisexercise = exerciseList[exerciseCount - 1]
        thisexercise.clearSets()
        for row in rows {
            print("Row: \(row.count)")
            print(exerciseCount)
            getWorkout().addNewSet(name: arrayOfExerciseNames[exerciseCount - 1], reps: row[0].text!, sets: row[1].text!, weight: row[2].text!, rest: row[3].text!)
        }
    }
    
    func addRow(isExercise: Bool) {
        if (isExercise) {
            let row = createRowOfTextFields(isExercise: true)
            rowStack.addArrangedSubview(row)
            addNewExercise(exerciseNum: exerciseCount)
            setCount = 1
            exerciseCount += 1
        } else {
            let row = createRowOfTextFields(isExercise: false)
            rowStack.addArrangedSubview(row)
            addNewSet()
            setCount += 1
        }
        rowCount += 1
    }
    
    func textfieldMaker() -> UITextField {
        let thisTextField: UITextField = {
            let txtField = UITextField()
            txtField.heightAnchor.constraint(equalToConstant: 25).isActive = true
            setUpTextFields(textField: txtField)
            txtField.translatesAutoresizingMaskIntoConstraints = false
            
            return txtField
        }()
        return thisTextField
    }
    
    // UI element creation
    
    // Creates and returns a stackview containing five textfields which represent one row in the
    // addWorkoutView
    func createRowOfTextFields(isExercise: Bool) -> UIStackView {
        let widtdthTextField = (view.frame.width - 100) / 5
        let stackview = UIStackView()
        let stackview2 = UIStackView()
        let stackview3 = UIStackView()
        var textFieldArray = [UITextField]()
        var setFieldArray = [UITextField]()
        let label = UILabel()
        label.text = ""
        label.textColor = Colors.greens
        label.font = UIFont(name: "Avenir next", size: 16)!
        
        if (isExercise) {
            rowsOfSets.removeAll()
            label.text = arrayOfExerciseNames[exerciseCount]
        } else {
            label.text = ""
        }
        for num in 1...4 {
            let textField = textfieldMaker()
            textField.textAlignment = .center
            if (num < 3) {
                stackview2.addArrangedSubview(textField)
            } else {
                stackview3.addArrangedSubview(textField)
            }
            textFieldArray.append(textField)
            setFieldArray.append(textField)
            textField.widthAnchor.constraint(equalToConstant: widtdthTextField)
        }
        setupStackViewHorizontal(stackview: stackview2)
        setupStackViewHorizontal(stackview: stackview3)
        setupStackViewHorizontal(stackview: stackview)
        
        stackview.addArrangedSubview(label)
        stackview.addArrangedSubview(stackview2)
        stackview.addArrangedSubview(stackview3)
        rows.append(textFieldArray)
        rowsOfSets.append(setFieldArray)
        return stackview
    }
    
    // returns a stackview that contains a row of labels which describe the textfields
    func createRowOfLabels() -> UIStackView {
        let stackview = UIStackView()
        let stackview2 = UIStackView()
        let stackview3 = UIStackView()
        for num in 1...5 {
            let label = UILabel()
            label.font = UIFont(name: "Avenir next", size: 16.0)!
            if (num == 1) {
                label.text = "Exercise"
                stackview.addArrangedSubview(label)
            }
            if (num == 2) {
                label.text = "Reps"
                stackview2.addArrangedSubview(label)
            }
            if (num == 3) {
                label.text = "Sets"
                stackview2.addArrangedSubview(label)
            }
            if (num == 4) {
                label.text = "Weight"
                stackview3.addArrangedSubview(label)
            }
            if (num == 5) {
                label.text = "Rest"
                stackview3.addArrangedSubview(label)
            }
            label.textColor = Colors.whites
        }
        setupStackViewHorizontal(stackview: stackview2)
        setupStackViewHorizontal(stackview: stackview3)
        setupStackViewHorizontal(stackview: stackview)
        
        stackview.addArrangedSubview(stackview2)
        stackview.addArrangedSubview(stackview3)
        return stackview
    }
    
    func showSetOrExerciseAlert() {
        
        let message = "You can totally do another set \nthat was easy bro"
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        // Style of the alert
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.darkGreen
        alert.view.tintColor = Colors.darkGrey
        
        alert.addAction(UIAlertAction(title: "Set", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("Should Change")
                self.addRow(isExercise: false)
                self.numSets += 1
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        alert.addAction(UIAlertAction(title: "Exercise", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.showExerciseChoice()
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { action in
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
    
    func showExerciseChoice() {
        let message = "Name of exercise:"
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Colors.darkGreen
        alert.view.tintColor = Colors.darkGrey
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = " "
            textField.adjustsFontForContentSizeCategory = true
            textField.backgroundColor = Colors.darkGreen
            textField.setBottomBorder(isDark: false, lineColor: Colors.grey!)
            //textField.superview?.backgroundColor = Colors.grey
        })
        
        alert.textFields?.forEach {
            $0.superview?.backgroundColor = .clear
            $0.superview?.superview?.subviews[0].removeFromSuperview()
        }
        
        alert.addAction(UIAlertAction(title: "add", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                print("Your exercisename: \(name)")
                self.arrayOfExerciseNames.append(name)
                self.setHowManySets(index: self.exerciseCount - 1)
                self.numSets = 1
                self.addRow(isExercise: true)
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    // Actions
    var clickcount = 0
    
   // Code for the add button below the rows of exercises
    @objc func addAction(sender:UIButton!) {
            showSetOrExerciseAlert()
            changeStatLabel(button: getButton())
    }
    
    @objc func backAction(sender:UIButton!) {
        regSegue()
    }
    
    func setHowManySets(index: Int) {
        howManySetsArray.insert(numSets, at: index)
        for set in howManySetsArray {
            print("Count of exercise sets: \(set)")
        }
    }
    
    
    @objc func saveAction() {
        print("Saving this many: \(howManySetsArray.count)")
        print("setcount: \(setCount)")
    }
    
    func checkIfEmpty(array: [UITextField]) -> Bool {
        for field in array {
                if (!field.text!.isEmpty) {
                    return false
                }
        }
        return true
    }
    
    @objc func deleteAction() {
        deleteWorkout(workout1: getWorkout())

    }
    
    func deleteWorkout(workout1: Workout2) {
        let log = TabBarViewController.workoutLog2
        let index = log.getWorkoutList().firstIndex(of: workout1)
        log.removeWorkoutAt(index: index!)
        let tab = TabBarViewController()
        saver.deleteOldFile(path: saver.getPathWorkout())
        //tab.setWorkoutList(log: log)
        saver.save(path: saver.getPathWorkout())
        regSegue()
    }
    
    func regSegue(){
        let page = NavigationViewController()
        present(page, animated: true, completion: nil)
    }
    

    
    func changeStatLabel(button: UIButton) {
        //let button = getButton()
        if (clickcount == 0) {
            print("hello")
            button.setTitle("Total Volume: \(getWorkout().getTotalReps())", for: .normal)
        } else if (clickcount == 1) {
            button.setTitle("Total Load: \(getWorkout().getTotalWeight())kg", for: .normal)
        } else {
            button.setTitle("Total sets: \(getWorkout().getTotalSets())", for: .normal)
        }
    }
    
    @objc func statAction(sender:UIButton!) {
        if (clickcount == 0) {
            clickcount += 1
            sender.setTitle("Total Load: \(getWorkout().getTotalWeight())kg", for: .normal)
        } else if (clickcount == 1) {
            sender.setTitle("Total sets: \(getWorkout().getTotalSets())", for: .normal)
            clickcount += 1
        } else {
            sender.setTitle("Total Volume: \(getWorkout().getTotalReps())", for: .normal)
            clickcount = 0
        }
    }
    
    @objc func save() {
        saver.deleteOldFile(path: saver.getPathWorkout())
        let bar = BarChartViewController()
        bar.setFresh(hasbeenLaunched: false)
        bar.setDiaryLaunch(hasbeenLaunched: true)
        saveWorkout(workout: getWorkout())
    }
    
    @objc func add() {
        changeStatLabel(button: getButton())
    }
    
    func saveWorkout(workout: Workout2) {
        print("Hey you")
        if (workout.getExercises().count != 0 && workout.getTotalReps() != 0) {
            let log = TabBarViewController.workoutLog2
            print("total workouts: \(log.getWorkoutList().count)")
            let tab = TabBarViewController()
            saver.deleteOldFile(path: saver.getPathWorkout())
            tab.setWorkoutList(log: log)
            saver.save(path: saver.getPathWorkout())
            
            for wout in TabBarViewController.workoutLog.getWorkoutList() {
                print("reps: \(wout.getTotalReps())")
                print("Date: \(wout.getDate())")
            }
        }
    }
    
    func saveButton() -> UIBarButtonItem {
        let button:UIBarButtonItem = {
            let btn = UIBarButtonItem()
            btn.title = "Save"
            btn.tintColor = Colors.greens
            btn.action = #selector(self.save)
            btn.target = self
            return btn
        }()
        return button
    }
    
    func adderButton() -> UIBarButtonItem {
        let button:UIBarButtonItem = {
            let btn = UIBarButtonItem()
            btn.title = "add"
            //btn.image = #imageLiteral(resourceName: "addIcon")
            btn.tintColor = Colors.greens
            btn.action = #selector(self.add)
            btn.target = self
            return btn
        }()
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.addSubview(contentView)
        self.navigationItem.title = "Date: \(getWorkout().getDate())"
        let textAttributes = [NSAttributedStringKey.foregroundColor: Colors.darkGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        startWorkout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

