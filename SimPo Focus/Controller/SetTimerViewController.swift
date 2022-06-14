//
//  SetTimerViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/13.
//

import UIKit

class SetTimerViewController: UIViewController {
  
  var state = ""
  var task = ""
  var timeSet = 0
  
  var stateLabel = UILabel()
  var taskLabel = UILabel()
  var timerTextField = UITextField()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Delegate
    timerTextField.delegate = self
    
    // View
    //TODO: - add a custom Switch for Input and Output
    self.view.backgroundColor = culturedWhite
    configureStateLabel()
    configureTaskLabel()
    configureTimerTextField()
  }
    
  func configureStateLabel() {
    view.addSubview(stateLabel)
    
    stateLabel.text = state
    stateLabel.accessibilityLabel = "\(state) Mode"
    stateLabel.font = .boldSystemFont(ofSize: 46)
    stateLabel.textColor = steelBlue
    stateLabel.textAlignment = .center
    
    stateLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
      stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  func configureTaskLabel() {
    view.addSubview(taskLabel)
    
    taskLabel.text = task
    taskLabel.font = .systemFont(ofSize: 28)
    taskLabel.textColor = steelBlue
    taskLabel.textAlignment = .center
    
    taskLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      taskLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 20),
      taskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  func configureTimerTextField() {
    view.addSubview(timerTextField)
    
    if state == "Focus" {
      timeSet = 25
    } else {
      timeSet = 5
    }
    timerTextField.text = "\(timeSet):00"
    timerTextField.textColor = steelBlue
    timerTextField.font = .systemFont(ofSize: 42)
    timerTextField.textAlignment = .center
    
    timerTextField.keyboardType = .numberPad
    
    timerTextField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      timerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timerTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

}

//MARK: - TimerTextFieldDelegate
extension SetTimerViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    timerTextField.text = String(timeSet)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    timeSet = Int(timerTextField.text ?? (state == "Focus" ? "25" : "5"))!
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    timerTextField.text = "\(timeSet):00"
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
