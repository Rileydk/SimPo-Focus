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
  
  let stateLabel = UILabel()
  let taskLabel = UILabel()
  let timerTextField = UITextField()
  let startButton = UIButton()
  let backButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Delegate
    timerTextField.delegate = self
    
    // View
    //TODO: - add SF Symbols to increase or decrease 5 min at a time
    //TODO: - add a custom Switch for Input and Output
    //TODO: - add a circular UISlider
    self.view.backgroundColor = culturedWhite
    configureStateLabel()
    configureTaskLabel()
    configureTimerTextField()
    configureStartButton()
    configureBackButton()
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
  
  //TODO: - 陰影效果、按壓時顏色加深
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
  
  func configureBackButton() {
    
    view.addSubview(backButton)
    backButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
    
    if #available(iOS 13.0, *) {
      let smallConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36))
      let backSymbol = UIImage(systemName: "chevron.backward.circle", withConfiguration: smallConfiguration)
      backButton.setImage(backSymbol, for: .normal)
      backButton.tintColor = opaqueSteelBlue
    } else {
      backButton.setTitle("Back", for: .normal)
      backButton.titleLabel?.font = .systemFont(ofSize: 28)
      backButton.titleLabel?.textAlignment = .left
      backButton.setTitleColor(opaqueSteelBlue, for: .normal)
    }
    
    backButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
      backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
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
  
  @objc func backToMainVC() {
    self.dismiss(animated: true)
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
