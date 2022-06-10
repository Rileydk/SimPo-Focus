//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import UIKit

class MainViewController: UIViewController {
  
  #warning("delete this line later")
  let testColor = UIColor(red: 240/255, green: 128/255, blue: 128/255, alpha: 1)
  
  let taskTextField = UITextField()
  let focusButton = UIButton()
  
  var timeBrain = TimeBrain()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// Configure View
    configureTaskTxtField()
    configureFoucusButton()
    
    /// Delegate
    taskTextField.delegate = self
    
    /// Start countdown
    timeBrain.min = 0
    timeBrain.sec = 0
    timeBrain.timer()
  }
  
  func configureTaskTxtField() {
    view.addSubview(taskTextField)
    
    taskTextField.placeholder = "What's Your Major Task?"
    taskTextField.backgroundColor = .none
    taskTextField.textColor = .darkGray
    taskTextField.borderStyle = .line
    taskTextField.textAlignment = .center
    taskTextField.font = .boldSystemFont(ofSize: 32)
    taskTextField.clearButtonMode = .whileEditing // 為什麼結束editing後，clear button消失，欄位卻不會回復？
    
    taskTextField.adjustsFontSizeToFitWidth = true
    taskTextField.minimumFontSize = 20
    
    taskTextField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      /// TaskTextField
      taskTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
      taskTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      taskTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 300)
    ])
  }
  
  func configureFoucusButton() {
    let steelBlue = UIColor(red: 63/255, green: 114/255, blue: 175/255, alpha: 1)
    let culturedWhite = UIColor(red: 249/255, green: 247/255, blue: 247/255, alpha: 1)
    
    view.addSubview(focusButton)
    focusButton.addTarget(self, action: #selector(goCountdownSetting), for: .touchUpInside)
    
    focusButton.backgroundColor = culturedWhite
    focusButton.setTitle("Focus", for: .normal)
    focusButton.setTitleColor(steelBlue, for: .normal)
    focusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    focusButton.titleLabel?.textAlignment = .center
    focusButton.layer.cornerRadius = 5
    
    focusButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      focusButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 50),
      focusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      focusButton.widthAnchor.constraint(equalToConstant: 150),
      focusButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  @objc func goCountdownSetting() {
    print("button pressed")
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
