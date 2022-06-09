//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import UIKit

class MainViewController: UIViewController {
  
  let taskTextField = UITextField()
  
  var timeBrain = TimeBrain()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Configure View
    configureTaskTextField()
    
    /// Delegate
    taskTextField.delegate = self
    
    /// Start countdown
    timeBrain.min = 0
    timeBrain.sec = 0
    timeBrain.timer()
  }
  
  func configureTaskTextField() {
    view.addSubview(taskTextField)
    
    taskTextField.translatesAutoresizingMaskIntoConstraints = false
    taskTextField.placeholder = "What's Your Major Task?"
    taskTextField.backgroundColor = .none
    taskTextField.textColor = .darkGray
    taskTextField.textAlignment = .center
    taskTextField.font = .boldSystemFont(ofSize: 24)
    taskTextField.clearButtonMode = .whileEditing // 為什麼結束editing後，clear button消失，欄位卻不會回復？
    
    taskTextField.adjustsFontSizeToFitWidth = true
    taskTextField.minimumFontSize = 20
    
    NSLayoutConstraint.activate([
      /// TaskTextField
      taskTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      taskTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
    ])
  }

}

//MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    taskTextField.resignFirstResponder()
    return true
  }
  
}
