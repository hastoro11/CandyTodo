//
//  NewTaskVC.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 30..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var priorityTextField: UITextField!
    
    //MARK: - vars
    var addButton: MiddleButton = {
        let btn = MiddleButton()
        btn.setImage(UIImage(named: "check"), for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return btn
    }()
    var datePicker = UIDatePicker()
    var priorityPicker = UIPickerView()
    var priorities = ["Low", "Medium", "High"]
    var selectedDate = Date()
    var selectedPriority = ""
    var enteredTask = ""

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        //Button
        view.addSubview(addButton)
        //TaskTextField
        taskTextField.delegate = self
        //Datepicker
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        //DateTextField
        dateTextField.delegate = self
        dateTextField.inputView = datePicker
        setDateTextField(with: selectedDate)
        //Prioritypicke
        priorityPicker.backgroundColor = .white
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
        //PriorityTextField
        priorityTextField.delegate = self
        priorityTextField.inputView = priorityPicker
        //GestureRecognizer
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.addTarget(self, action: #selector(handleViewTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: - Actions
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: (view.bounds.width - 80) / 2, y: view.bounds.height - 40 - 72, width: 80, height: 72)
    }
    
    //MARK: - Helpers
    func setDateTextField(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MMM dd. HH:mm"
        dateTextField.text = dateFormatter.string(from: date)
    }
    
    //MARK: - Selectors
    @objc func addButtonTapped() {
        if enteredTask.isEmpty || selectedPriority.isEmpty {
            print("Invalid")
            return
        }
        print("OK")
    }
    
    @objc func dateSelected(sender: UIDatePicker) {
        selectedDate = sender.date
        setDateTextField(with: selectedDate)
    }
    
    @objc func handleViewTap() {
        taskTextField.resignFirstResponder()
        priorityTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
    }
}

//MARK: - UITextFieldDelegate
extension NewTaskVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != taskTextField {
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == taskTextField {
            if let task = textField.text, !task.isEmpty {
                enteredTask = task
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension NewTaskVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorities[row]
        priorityTextField.text = priorities[row]
    }
}
