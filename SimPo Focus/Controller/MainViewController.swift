//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import UIKit

class MainViewController: UIViewController {
  
  let taskTextField = UITextField(frame: CGRect(x: 10, y: 100, width: 400, height: 30))
  
  var timeBrain = TimeBrain()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Delegate
    taskTextField.delegate = self
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    /// Display View
    taskTextField.placeholder = "What's Your Major Task?"
    taskTextField.borderStyle = .none
    taskTextField.backgroundColor = .none
    taskTextField.textColor = UIColor.darkGray
    taskTextField.font = UIFont.boldSystemFont(ofSize: 24)
    // taskTextField.adjustsFontSizeToFitWidth = true
    // taskTextField.minimumFontSize = 20
    taskTextField.clearButtonMode = .whileEditing
    self.view.addSubview(taskTextField)
    
    /// Start countdown
    timeBrain.min = 1
    timeBrain.sec = 15
    // timeBrain.timer()
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
