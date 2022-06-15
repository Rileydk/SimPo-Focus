//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

//FIXME: - Cannot launch on iOS version lower than 13

import UIKit

class MainViewController: UIViewController {
  
  //TODO: - try changing to UITextView to fulfill mutiple lines task title
  let brandLabel = UILabel()
  let taskTextField = UITextField()
  let focusButton = UIButton()
  let breakButton = UIButton()
  
  // Info
  let taskTextFieldPlaceholder = "Your Major Task"

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // View
    self.view.backgroundColor = steelBlue
    configureBrandLabel()
    configureTaskTextField()
    configureFoucusButton()
    configureBreakButton()
    
    // Delegate
    taskTextField.delegate = self
  }
  
  func configureBrandLabel() {
    view.addSubview(brandLabel)
    
    brandLabel.text = "SimPo Focus"
    brandLabel.textColor = culturedWhite
    brandLabel.font = .systemFont(ofSize: 28)
    brandLabel.textAlignment = .center
    
    brandLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      brandLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
      brandLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  func configureTaskTextField() {
    view.addSubview(taskTextField)
    
    //TODO: - 限制長度或字數（區分中英文？）
    //TODO: - clearButton導致的text位移（inset）處理
    //TODO: - change font？
    taskTextField.attributedPlaceholder = NSAttributedString(
      string: taskTextFieldPlaceholder,
      attributes: [NSAttributedString.Key.foregroundColor: culturedWhite]
    )
    taskTextField.accessibilityLabel = "Set Your Major Task Here"
    taskTextField.tintColor = culturedWhite
    taskTextField.backgroundColor = .none
    taskTextField.textColor = culturedWhite
    taskTextField.textAlignment = .center
    taskTextField.font = .boldSystemFont(ofSize: 46)
    taskTextField.clearButtonMode = .whileEditing
    taskTextField.keyboardType = .default
    
    taskTextField.adjustsFontSizeToFitWidth = true
    taskTextField.minimumFontSize = 28
    
    taskTextField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      taskTextField.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
      taskTextField.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
      taskTextField.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 30),
      taskTextField.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 30),
      taskTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      taskTextField.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
    ])
  }
  
  //TODO: - 陰影效果
  //TODO: - 按住時顏色加深且無陰影，形成按壓感
  func configureFoucusButton() {
    
    view.addSubview(focusButton)
    focusButton.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
    focusButton.addTarget(self, action: #selector(changeButtonBackgroundColorWhenTouchUpInside), for: .touchDown)
    focusButton.addTarget(self, action: #selector(changeButtonBackgroundColorWhenReleased), for: .touchUpOutside)
    
    focusButton.backgroundColor = culturedWhite
    focusButton.setTitle("Focus", for: .normal)
    focusButton.accessibilityLabel = "Start Focus"
    focusButton.setTitleColor(steelBlue, for: .normal)
    focusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
    focusButton.titleLabel?.textAlignment = .center
    focusButton.layer.cornerRadius = 5
    focusButton.layer.name = "Focus"
    
    focusButton.layer.shadowColor = darkCerulean.cgColor
    focusButton.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
    focusButton.layer.shadowOpacity = 1.0
    focusButton.layer.shadowRadius = 0.0
    
    focusButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      focusButton.topAnchor.constraint(greaterThanOrEqualTo: taskTextField.bottomAnchor, constant: 80),
      focusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      focusButton.widthAnchor.constraint(equalToConstant: 250),
      focusButton.heightAnchor.constraint(equalToConstant: 67)
    ])
  }
  
  func configureBreakButton() {
    
    view.addSubview(breakButton)
    breakButton.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
    breakButton.addTarget(self, action: #selector(changeButtonBackgroundColorWhenTouchUpInside), for: .touchDown)
    breakButton.addTarget(self, action: #selector(changeButtonBackgroundColorWhenReleased), for: .touchUpOutside)
    
    breakButton.backgroundColor = culturedWhite
    breakButton.setTitle("Break", for: .normal)
    breakButton.accessibilityLabel = "Take a Break"
    breakButton.setTitleColor(steelBlue, for: .normal)
    breakButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
    breakButton.titleLabel?.textAlignment = .center
    breakButton.layer.cornerRadius = 5
    breakButton.layer.name = "Break"
    
    breakButton.layer.shadowColor = darkCerulean.cgColor
    breakButton.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
    breakButton.layer.shadowOpacity = 1.0
    breakButton.layer.shadowRadius = 0.0
    
    breakButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      breakButton.topAnchor.constraint(equalTo: focusButton.bottomAnchor, constant: 30),
      breakButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
      breakButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      breakButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      breakButton.widthAnchor.constraint(equalToConstant: 250),
      breakButton.heightAnchor.constraint(equalToConstant: 67)
    ])
    
  }
  
  @objc func buttonTouchUpInside(sender: UIButton) {
    goSetTimerVC(sender: sender)
    changeButtonBackgroundColorWhenReleased(sender: sender)
  }
  
  func goSetTimerVC(sender: UIButton) {
    let setTimerVC = SetTimerViewController()
    
    // 將所選模式和任務傳送到setTimerVC
    if sender.layer.name == "Focus" {
      setTimerVC.state = .focusMode
      setTimerVC.task = taskTextField.text ?? "My Task"
    } else {
      setTimerVC.state = .breakMode
    }
    
    setTimerVC.modalPresentationStyle = .fullScreen
    self.present(setTimerVC, animated: true)
  }
  
  //TODO: - 如何在點擊時將button的constraints移動相對距離？
  @objc func changeButtonBackgroundColorWhenTouchUpInside(sender: UIButton) {
    sender.backgroundColor = gainsboro
    sender.layer.shadowColor = spaceCadet.cgColor
  }
  
  @objc func changeButtonBackgroundColorWhenReleased(sender: UIButton) {
    sender.backgroundColor = culturedWhite
    sender.layer.shadowColor = darkCerulean.cgColor
  }

}

//MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
  
  // 開始輸入時清空placeholder
  func textFieldDidBeginEditing(_ textField: UITextField) {
    taskTextField.placeholder = ""
  }
  
  // 點擊空白處收起鍵盤
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  // 點擊Return時收起鍵盤
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    taskTextField.resignFirstResponder()
    return true
  }
  
  // 若未輸入，放回預設的placeholder
  func textFieldDidEndEditing(_ textField: UITextField) {
    taskTextField.placeholder =  taskTextField.text != "" ? .none : taskTextFieldPlaceholder
  }
  
}
