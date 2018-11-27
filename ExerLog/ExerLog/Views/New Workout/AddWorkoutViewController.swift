

import UIKit

class AddWorkoutViewController: UIViewController {
    
    var workout: Workout?
    var workout2: Workout2?
    var isFirstAdd = true
    var rowsOfSets = [[UITextField]]()
    var howManySetsArray = [Int]()
    var numSets = 0
    
    var arrayOfExerciseNames = [String]()
    let saver = Saver()
    
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
            btn.titleLabel?.font = UIFont(name: "Avenir next", size: 18)!
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
//
//        let row = createRowOfTextFields()
//        rowStack.addArrangedSubview(row)
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
        let colors = Colors()
        textField.backgroundColor = Colors.grey
        
        textField.setBottomBorder(isDark: colors.isDarkTheme(), lineColor: Colors.greens!)
        //textField.borderStyle = .none
        textField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        textField.textColor = Colors.greens
       // textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    func startWorkout() {
        workout2 = Workout2()
        for row in rowStack.arrangedSubviews {
            rowStack.removeArrangedSubview(row)
            row.removeFromSuperview()
        }
        rows.removeAll()
        autoLayoutConstraint()
    }


    func addNewExercise(exerciseNum: Int) {
        workout2!.clearExercises()
        print("Exercise: \(arrayOfExerciseNames[exerciseNum])")
        for array in rows {
            workout2!.addNewExercise(name: arrayOfExerciseNames[exerciseNum], reps: array[0].text!, sets: array[1].text!, weight: array[2].text!, rest: array[3].text!)
        }
        print(workout2!.getExercises().count)
        print(workout2!.getTotalReps())
    }
    func addNewSet() {
        print("This is setcount: \(setCount)")
        print("This is exercount: \(exerciseCount)")
        let exerciseList = workout2!.getExercises()
        let thisexercise = exerciseList[exerciseCount - 1]
        thisexercise.clearSets()
        for row in rowsOfSets {
            workout2!.addNewSet(name: arrayOfExerciseNames[exerciseCount - 1], reps: row[0].text!, sets: row[1].text!, weight: row[2].text!, rest: row[3].text!)
        }
    }
    
    var rowCount = 0
    var exerciseCount = 0
    var setCount = 0
    
    func addRow(isExercise: Bool) {
        if (isFirstAdd) {
                let row = createRowOfTextFields(isExercise: true)
                rowStack.addArrangedSubview(row)
                setCount = 1
                //exerciseCount += 1
        } else {
            if (isExercise) {
                let row = createRowOfTextFields(isExercise: true)
                rowStack.addArrangedSubview(row)
                addNewExercise(exerciseNum: exerciseCount)
                setCount = 1
               // exerciseCount += 1
            } else {
                let row = createRowOfTextFields(isExercise: false)
                rowStack.addArrangedSubview(row)
                addNewSet()
                setCount += 1
            }
        }
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
//        let Exercisebutton = UIView()
//        Exercisebutton.addSubview(label)
//        Exercisebutton.widthAnchor.constraint(equalToConstant: 100)
        //textFieldArray.append(Exercisebutton)
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
            label.font = UIFont(name: "Avenir next", size: 16)!
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
   
    
    @objc func statAction(sender:UIButton!) {

        if (clickcount == 0) {
            clickcount += 1
            setLabels()
        } else if (clickcount == 1) {
            clickcount += 1
            setLabels()
        } else {
            clickcount = 0
            setLabels()
        }
    }
    
    @objc func save() {
        
        self.setHowManySets(index: self.exerciseCount - 1)
        numSets = 1
        saver.deleteOldFile(path: saver.getPathWorkout())
        workout2!.clearExercises()
        exerciseCreator()
        TabBarViewController.workoutLog2.addWorkout(workout: workout2!)
        saveWorkout(workout: workout2!)
        numberOfExercisesAdded = 0
    }
    var numberOfExercisesAdded = 0
    
    func exerciseCreator() {
        var countOfExercises = 0
        var countOfRows = 0
        for exercises in howManySetsArray{
            for n in 1...exercises {
                if (n == 1) {
                    print("Name of exercise: \(arrayOfExerciseNames[countOfExercises])")
                    print("Sets: \(rows[countOfRows][1].text!)")
                    workout2!.addNewExercise(name: arrayOfExerciseNames[countOfExercises], reps: rows[countOfRows][0].text!, sets: rows[countOfRows][1].text!, weight: rows[countOfRows][2].text!, rest: rows[countOfRows][3].text!)
                } else {
                    print("Name of exercise: \(arrayOfExerciseNames[countOfExercises])")
                    print("Sets: \(rows[countOfRows][1].text!)")
                    workout2!.addNewSet(name: arrayOfExerciseNames[countOfExercises], reps: rows[countOfRows][0].text!, sets: rows[countOfRows][1].text!, weight: rows[countOfRows][2].text!, rest: rows[countOfRows][3].text!)
                }
                countOfRows += 1
            }
            print("\nExercise added\n")
            countOfExercises += 1
        }
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
        if (isFirstAdd) {
            showExerciseChoice()
        } else {
            showSetOrExerciseAlert()
        }
        setLabels()
    }
    
    func saveWorkout(workout: Workout2) {
        print("Hey you")
        if (workout.getExercises().count != 0 && workout.getTotalReps() != 0) {
            workout.setDate()
            workout.setId(num: TabBarViewController.workoutLog2.getWorkoutList().count + 1)
            let log2 = TabBarViewController.workoutLog2
            log2.addWorkout(workout: workout2!)

            print("total workouts: \(log2.getWorkoutList().count)")
            saver.save(path: saver.getPathWorkout())
            startWorkout()
            
            for wout in TabBarViewController.workoutLog2.getWorkoutList() {
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
    
    func setLabels() {
        let button = getButton()
        if (clickcount == 0) {
            print("hello")
            button.setTitle("Total Volume: \(self.workout2!.getTotalReps())", for: .normal)
        } else if (clickcount == 1) {
            button.setTitle("Total Load: \(self.workout2!.getTotalWeight())kg", for: .normal)
        } else {
            button.setTitle("Total sets: \(self.workout2!.getTotalSets())", for: .normal)
        }
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
    
    func setHowManySets(index: Int) {
        howManySetsArray.insert(numSets, at: index)
        for set in howManySetsArray {
            print("Count of exercise sets: \(set)")
        }
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
                if (!self.isFirstAdd) {
                    self.setHowManySets(index: self.exerciseCount - 1)
                } else {
                    self.isFirstAdd = false
                }
                self.arrayOfExerciseNames.append(name)
                self.addRow(isExercise: true)
                self.exerciseCount += 1
                self.numSets = 1
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tab = TabBarViewController()
        //tab.setIsWorkoutController(isWorkout: false)
        hideKeyboardWhenTappedAround()
        view.addSubview(contentView)
        startWorkout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {

        isFirstAdd = true
        exerciseCount = 0
        let font = UIFont.systemFont(ofSize: 32);
        
        let savebutton = barButton()
        savebutton.title = "Save"
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = savebutton
        savebutton.action = #selector(save)
        let adderbutton = barButton()
        adderbutton.title = "+"
        adderbutton.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = adderbutton
        adderbutton.action = #selector(add)
        self.viewDidLoad()
    }

}

