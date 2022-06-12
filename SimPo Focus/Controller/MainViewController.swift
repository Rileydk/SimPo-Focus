//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import UIKit

class MainViewController: UIViewController {
  
  //TODO: - try changing to UITextView to fulfill mutiple lines task title
  let taskTextField = UITextField()
  let focusButton = UIButton()
  let breakButton = UIButton(frame: CGRect(x: 30, y: 200, width: 50, height: 20))
  
  var timeBrain = TimeBrain()
  
  // Colors
  #warning("delete this line after finish all view settings")
  let testColor = UIColor(red: 240/255, green: 128/255, blue: 128/255, alpha: 1)
  
  let steelBlue = UIColor(red: 63/255, green: 114/255, blue: 175/255, alpha: 1)
  let culturedWhite = UIColor(red: 249/255, green: 247/255, blue: 247/255, alpha: 1)
  
  // Info
  let taskTextFieldPlaceholder = "Your Major Task"

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // View
    self.view.backgroundColor = steelBlue
    configureTaskTextField()
    configureFoucusButton()
    configureBreakButton()
    
    // Delegate
    taskTextField.delegate = self
    
    // Start countdown
    timeBrain.min = 0
    timeBrain.sec = 0
    timeBrain.timer()
  }
  
  func configureTaskTextField() {
    view.addSubview(taskTextField)
    
    //TODO: - 無法輸入中文
    //TODO: - 結束editing後，clear button所導致的欄位拉長
    //TODO: - 限制長度或字數（區分中英文？）
    //TODO: - 可選擇想修改的位置（目前只能從最前面或最後面開始移動）
    taskTextField.attributedPlaceholder = NSAttributedString(
      string: taskTextFieldPlaceholder,
      attributes: [NSAttributedString.Key.foregroundColor: culturedWhite]
    )
    taskTextField.tintColor = culturedWhite
    taskTextField.backgroundColor = .none
    taskTextField.textColor = culturedWhite
    taskTextField.borderStyle = .line
    taskTextField.textAlignment = .center
    //TODO: - change font
    taskTextField.font = .boldSystemFont(ofSize: 32)
    taskTextField.clearButtonMode = .whileEditing
    
    taskTextField.adjustsFontSizeToFitWidth = true
    taskTextField.minimumFontSize = 22
    
    taskTextField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      taskTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
      taskTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      taskTextField.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
    ])
  }
  
  func configureFoucusButton() {
    
    view.addSubview(focusButton)
    focusButton.addTarget(self, action: #selector(goCountdownSetting), for: .touchUpInside)
    
    focusButton.backgroundColor = culturedWhite
    focusButton.setTitle("Focus", for: .normal)
    focusButton.setTitleColor(steelBlue, for: .normal)
    //TODO: - change font
    focusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
    focusButton.titleLabel?.textAlignment = .center
    focusButton.layer.cornerRadius = 5
    
    focusButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      focusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
      //FIXME: - adjust priority
      focusButton.topAnchor.constraint(greaterThanOrEqualTo: taskTextField.bottomAnchor, constant: 100),
      focusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      focusButton.widthAnchor.constraint(equalToConstant: 250),
      focusButton.heightAnchor.constraint(equalToConstant: 67)
    ])
  }
  
  func configureBreakButton() {
    
    view.addSubview(breakButton)
    breakButton.addTarget(self, action: #selector(goCountdownSetting), for: .touchUpInside)
    
    breakButton.backgroundColor = culturedWhite
    breakButton.setTitle("Break", for: .normal)
    breakButton.setTitleColor(steelBlue, for: .normal)
    //TODO: - change font
    breakButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
    breakButton.titleLabel?.textAlignment = .center
    breakButton.layer.cornerRadius = 5
    
    breakButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      breakButton.topAnchor.constraint(equalTo: focusButton.bottomAnchor, constant: 30),
      breakButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      breakButton.widthAnchor.constraint(equalToConstant: 250),
      breakButton.heightAnchor.constraint(equalToConstant: 67)
    ])
    
  }
  
  //TODO: - add segue(?)
  //TODO: - bring title and state to next page
  @objc func goCountdownSetting() {
    print("button pressed")
  }

}

//MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    taskTextField.placeholder = ""
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    taskTextField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    taskTextField.placeholder =  taskTextField.text != "" ? .none : taskTextFieldPlaceholder
  }
  
}
