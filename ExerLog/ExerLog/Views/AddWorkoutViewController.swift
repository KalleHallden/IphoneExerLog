

import UIKit

class AddWorkoutViewController: UIViewController {
    
    var workout: Workout?
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
    
//    func addButton() -> UIButton {
//        let button:UIButton = {
//            let btn = UIButton(type:.system)
//            btn.backgroundColor = Colors.greens
//            btn.setTitle("ADD", for: .normal)
//            btn.tintColor = Colors.grey
//            btn.layer.cornerRadius = 0
//            btn.translatesAutoresizingMaskIntoConstraints = false
//            return btn
//        }()
//        return button
//    }
    
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
    
    func setUpMasterStack() -> UIStackView {
        
        var num = 0
        for subview in masterStackView.arrangedSubviews {
            masterStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
            num += 1
            print("This is num: \(num)")
        }
        
        setStatBut()
        let statbutton = getButton()
        statbutton.addTarget(self, action: #selector(statAction), for: .touchUpInside)
        
        masterStackView.addArrangedSubview(statbutton)
        
        let labelRow = createRowOfLabels()
        masterStackView.addArrangedSubview(labelRow)
        
        let row = createRowOfTextFields()
        rowStack.addArrangedSubview(row)
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
        textField.backgroundColor = Colors.greens
        textField.borderStyle = .none
        textField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        textField.textColor = Colors.grey
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func startWorkout() {
        workout = Workout()
        for row in rowStack.arrangedSubviews {
            rowStack.removeArrangedSubview(row)
            row.removeFromSuperview()
        }
        rows.removeAll()
        autoLayoutConstraint()
        let savebutton = saveButton()
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = savebutton
        let adderbutton = adderButton()
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = adderbutton
    }


    func addNewExercise(exerciseNum: Int) {
        workout!.clearExercises()
        for array in rows {
            workout!.addNewExercise(name: array[0].text!, reps: array[1].text!, sets: array[2].text!, weight: array[3].text!, rest: array[4].text!)
        }
        print(workout!.getExercises().count)
        print(workout!.getTotalReps())
    }
    
    var rowCount = 1;
    func addRow() {
        let row = createRowOfTextFields()
        rowStack.addArrangedSubview(row)
        addNewExercise(exerciseNum: rowCount)
        rowCount += 1
    }
    
    func textfieldMaker() -> UITextField {
        let thisTextField: UITextField = {
            let txtField = UITextField()
            setUpTextFields(textField: txtField)
            txtField.translatesAutoresizingMaskIntoConstraints = false
            
            return txtField
        }()
        return thisTextField
    }
    
    // UI element creation
    
    // Creates and returns a stackview containing five textfields which represent one row in the
    // addWorkoutView
    func createRowOfTextFields() -> UIStackView {
        let widtdthTextField = (view.frame.width - 100) / 5
        let stackview = UIStackView()
        let stackview2 = UIStackView()
        let stackview3 = UIStackView()
        var textFieldArray = [UITextField]()
        
        let textfield = textfieldMaker()
        textfield.widthAnchor.constraint(equalToConstant: 100)
        textFieldArray.append(textfield)
        for num in 1...4 {
            let textField = textfieldMaker()
            textField.textAlignment = .center
            if (num < 3) {
               stackview2.addArrangedSubview(textField)
            } else {
                stackview3.addArrangedSubview(textField)
            }
            textFieldArray.append(textField)
                textField.widthAnchor.constraint(equalToConstant: widtdthTextField)
        }
        setupStackViewHorizontal(stackview: stackview2)
        setupStackViewHorizontal(stackview: stackview3)
        setupStackViewHorizontal(stackview: stackview)
        
        stackview.addArrangedSubview(textfield)
        stackview.addArrangedSubview(stackview2)
        stackview.addArrangedSubview(stackview3)
        rows.append(textFieldArray)
        
        return stackview
    }
    
    // returns a stackview that contains a row of labels which describe the textfields
    func createRowOfLabels() -> UIStackView {
        let stackview = UIStackView()
        let stackview2 = UIStackView()
        let stackview3 = UIStackView()
        for num in 1...5 {
            let label = UILabel()
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
    
    // Actions
    var clickcount = 0
   
    //Code for the add button below the rows of exercises
//    @objc func action(sender:UIButton!) {
//        addRow()
//        let button = getButton()
//        if (clickcount == 0) {
//            print("hello")
//            button.setTitle("Total Volume: \(self.workout.getTotalReps())", for: .normal)
//        } else if (clickcount == 1) {
//            button.setTitle("Total Load: \(self.workout.getTotalWeight())kg", for: .normal)
//        } else {
//            button.setTitle("Total sets: \(self.workout.getTotalSets())", for: .normal)
//        }
//    }
    
    @objc func statAction(sender:UIButton!) {
        if (clickcount == 0) {
            clickcount += 1
            sender.setTitle("Total Load: \(workout!.getTotalWeight())kg", for: .normal)
        } else if (clickcount == 1) {
            sender.setTitle("Total sets: \(workout!.getTotalSets())", for: .normal)
            clickcount += 1
        } else {
            sender.setTitle("Total Volume: \(workout!.getTotalReps())", for: .normal)
            clickcount = 0
        }
    }
    
    @objc func save() {
        let tab = TabBarViewController()
        tab.deleteOldFile()
        workout!.clearExercises()
        for array in rows {
            if (!checkIfEmpty(array: array)) {
                workout!.addNewExercise(name: array[0].text!, reps: array[1].text!, sets: array[2].text!, weight: array[3].text!, rest: array[4].text!)
            }
        }
        saveWorkout(workout: workout!)
    }
    
    
    func checkIfEmpty(array: [UITextField]) -> Bool {
        for field in array {
            if (!field.text!.isEmpty) {
                return false
            }
        }
        return true
    }
    
    @objc func add() {
        addRow()
        let button = getButton()
        if (clickcount == 0) {
            print("hello")
            button.setTitle("Total Volume: \(self.workout!.getTotalReps())", for: .normal)
        } else if (clickcount == 1) {
            button.setTitle("Total Load: \(self.workout!.getTotalWeight())kg", for: .normal)
        } else {
            button.setTitle("Total sets: \(self.workout!.getTotalSets())", for: .normal)
        }
    }
    
    func saveWorkout(workout: Workout) {
        print("Hey you")
        if (workout.getExercises().count != 0 && workout.getTotalReps() != 0) {
            workout.setDate()
            workout.setId(num: TabBarViewController.workoutLog.getWorkoutList().count + 1)
            let log = TabBarViewController.workoutLog
            log.addWorkout(workout: workout)

            print("total workouts: \(log.getWorkoutList().count)")
            let tab = TabBarViewController()
            tab.saveMe()
            startWorkout()
            
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
            btn.tintColor = Colors.darkGreen
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
            btn.tintColor = Colors.darkGreen
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
        startWorkout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

