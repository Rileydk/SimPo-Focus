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
  var startButton = UIButton()

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
    configureStartButton()
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
    timerTextField.text = unitDigitAdjusted()
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
  
  func configureStartButton() {
    view.addSubview(startButton)
    startButton.addTarget(self, action: #selector(startCountdown), for: .touchUpInside)
    
    startButton.setTitle("Start", for: .normal)
    startButton.accessibilityLabel = "Take a Break"
    startButton.backgroundColor = steelBlue
    startButton.setTitleColor(culturedWhite, for: .normal)
    startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
    startButton.titleLabel?.textAlignment = .center
    startButton.layer.cornerRadius = 5
    
    startButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.widthAnchor.constraint(equalToConstant: 250),
      startButton.heightAnchor.constraint(equalToConstant: 67)
    ])
  }
  
  func unitDigitAdjusted() -> String {
    if (timeSet != 10) && (timeSet / 10 == 0) {
      return "0\(timeSet):00"
    } else {
      return "\(timeSet):00"
    }
  }
  
  @objc func startCountdown() {
    print("Start countdown")
  }

}

//MARK: - TimerTextFieldDelegate
extension SetTimerViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    timerTextField.text = String(timeSet)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    timeSet = Int(timerTextField.text!) ?? (state == "Focus" ? 25 : 5)
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    timerTextField.text = unitDigitAdjusted()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
