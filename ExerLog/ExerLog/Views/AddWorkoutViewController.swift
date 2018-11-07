

import UIKit

class AddWorkoutViewController: UIViewController {
    
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
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.heightAnchor.constraint(equalToConstant: 250).isActive = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        autoLayoutConstraint()
    }
    
    func autoLayoutConstraint() {
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
    
    func setup() {
        let workout = Workout()
        workout.addNewExercise(name: "Bench Press", reps: "12", sets: "3", weight: "20,3kg", rest: "60s")
        workout.addNewExercise(name: "Deadlift", reps: "5", sets: "5", weight: "122,5kg", rest: "120s")
        workout.addNewExercise(name: "Squat", reps: "8", sets: "3", weight: "180kg", rest: "120s")
        
        print(workout.getExercises().count)
        let list = workout.getExercises()
        
        workout.setTotalWeight(listExercise: list)
        workout.setTotalReps(listExercise: list)
        workout.setTotalSets(listExercise: list)
        print("\(workout.getTotalWeight()) kg")
        print("\(workout.getTotalReps()) reps")
        print("\(workout.getTotalSets())  sets")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addRow() {
        let row = createRowOfTextFields()
        rowStack.addArrangedSubview(row)
    }
    
    func setUpMasterStack() -> UIStackView {
        let labelRow = createRowOfLabels()
        masterStackView.addArrangedSubview(labelRow)
        
        let row = createRowOfTextFields()
        rowStack.addArrangedSubview(row)
        scrollView.addSubview(rowStack)
        rowStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        rowStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        rowStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        rowStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        scrollView.isScrollEnabled = true
        masterStackView.addArrangedSubview(scrollView)
        let button = addButton()
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        masterStackView.addArrangedSubview(button)
        return masterStackView
    }
    
    func addButton() -> UIButton {
        let button:UIButton = {
            let btn = UIButton(type:.system)
            btn.backgroundColor = Colors.green
            btn.setTitle("ADD", for: .normal)
            btn.tintColor = Colors.grey
            btn.layer.cornerRadius = 0
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        return button
    }
    
    @objc func action(sender:UIButton!) {
        addRow()
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
    
    func createRowOfTextFields() -> UIStackView {
        var widtdthTextField = (view.frame.width - 100) / 5
        let stackview = UIStackView()
        var textFieldArray = [UITextField]()
        for num in 1...5 {
            let textField = textfieldMaker()
            stackview.addArrangedSubview(textField)
            textFieldArray.append(textField)
            if (num == 5) {
                textField.widthAnchor.constraint(equalToConstant: 100)
            } else {
                textField.widthAnchor.constraint(equalToConstant: widtdthTextField)
            }
        }
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        rows.append(textFieldArray)
        return stackview
    }
    
    func createRowOfLabels() -> UIStackView {
        let stackview = UIStackView()
        for num in 1...5 {
            let label = UILabel()
            if (num == 1) {
                label.text = "Exercise"
            }
            if (num == 2) {
                label.text = "Reps"
            }
            if (num == 3) {
                label.text = "Sets"
            }
            if (num == 4) {
                label.text = "Weight"
            }
            if (num == 5) {
                label.text = "Rest"
            }
            label.textColor = .white
            
            stackview.addArrangedSubview(label)
        }
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }
    
    func setUpTextFields(textField: UITextField) {
        textField.backgroundColor = Colors.green
        textField.borderStyle = .none
        textField.textColor = Colors.grey
        textField.translatesAutoresizingMaskIntoConstraints = false
    }


}

