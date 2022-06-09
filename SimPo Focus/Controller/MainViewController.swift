//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import UIKit

class MainViewController: UIViewController {
  
  let taskTextField: UITextField = {
    let textField = UITextField(frame: CGRect(x: 10, y: 100, width: 400, height: 30))
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What's Your Major Task?"
    textField.borderStyle = .none
    textField.backgroundColor = .none
    textField.textColor = .darkGray
    textField.font = .boldSystemFont(ofSize: 24)
    textField.adjustsFontSizeToFitWidth = true
    textField.minimumFontSize = 20
    textField.clearButtonMode = .whileEditing
    
    return textField
  }()
  
  var timeBrain = TimeBrain()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Delegate
    taskTextField.delegate = self
    
    /// Display View
    view.addSubview(taskTextField)
    
    /// Start countdown
    timeBrain.min = 0
    timeBrain.sec = 0
    timeBrain.timer()
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
