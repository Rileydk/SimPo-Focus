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
    textField.borderStyle = .line
    textField.backgroundColor = .none
    textField.textColor = .darkGray
    textField.textAlignment = .center
    textField.font = .boldSystemFont(ofSize: 24)
    textField.adjustsFontSizeToFitWidth = true
    textField.minimumFontSize = 20
    textField.clearButtonMode = .whileEditing // 為什麼結束editing後，clear button消失，欄位卻不會回復？
    
    return textField
  }()
  
  var timeBrain = TimeBrain()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Delegate
    taskTextField.delegate = self
    
    /// Display View
    view.addSubview(taskTextField)
    configureConstraints()
    
    /// Start countdown
    timeBrain.min = 0
    timeBrain.sec = 0
    timeBrain.timer()
  }
  
  func configureConstraints() {
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
