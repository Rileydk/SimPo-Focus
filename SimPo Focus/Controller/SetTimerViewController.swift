//
//  SetTimerViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/13.
//

//TODO: - 開始計時後，Stop和Pause鍵出現
//TODO: - 點擊Pause，暫停計時，Pause按鈕變為Continue。
//TODO: - 點擊Stop，暫停計時，跳出alert，若選擇Cancel，關閉提醒，進入暫停模式；點擊Confirm，結束計時，回到Main。
//TODO: - 點擊Continue，繼續計時。

import UIKit

let focusLimit = 120
let breakLimit = 35

class SetTimerViewController: UIViewController {
  
  enum stateMode: String {
    case focusMode = "Focus"
    case breakMode = "Break"
  }
  var state: stateMode = .focusMode
  var task = ""
  var timeSet = 0
  var totalSec: Int { timeSet * 60 }
  
  let stackView = UIStackView()
  let stateLabel = UILabel()
  let taskLabel = UILabel()
  let timerTextField = UITextField()
  let startButton = UIButton()
  let backButton = UIButton()
  let stopButton = UIButton()
  let pauseButton = UIButton()

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
    configureBackButton()
    configureStackView()
    configureStopButton()
    configurePauseButton()
    configureStartButton()
  }
    
  func configureStateLabel() {
    view.addSubview(stateLabel)
    
    stateLabel.text = state.rawValue
    stateLabel.accessibilityLabel = "\(state.rawValue) Mode"
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
    
    // 根據當前不同的state，給予不同的timeSet
    if state == .focusMode {
      timeSet = 25
    } else {
      timeSet = 5
    }
    // 處理0或個位數的情形
    timerTextField.text = "\(unitDigitAdjusted(time: timeSet)):00"
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
    startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    startButton.addTarget(self, action: #selector(changeButtonBackgroundColorWhenTouchUpInside), for: .touchDown)
    startButton.addTarget(self, action: #selector(changeButtonBackgroundColorWhenReleased), for: .touchUpOutside)
    
    startButton.setTitle("Start", for: .normal)
    startButton.accessibilityLabel = "Take a Break"
    startButton.backgroundColor = steelBlue
    startButton.setTitleColor(culturedWhite, for: .normal)
    startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
    startButton.titleLabel?.textAlignment = .center
    startButton.layer.cornerRadius = 5
    
    startButton.layer.shadowColor = coolGray.cgColor
    startButton.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
    startButton.layer.shadowOpacity = 1.0
    startButton.layer.shadowRadius = 0.0
    
    startButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.widthAnchor.constraint(equalToConstant: 250),
      startButton.heightAnchor.constraint(equalToConstant: 67)
    ])
  }
  
  func configureBackButton() {
    view.addSubview(backButton)
    backButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
    
    // SF Symbol僅適用於iOS 13以上版本
    if #available(iOS 13.0, *) {
      let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36))
      let backSymbol = UIImage(systemName: "chevron.backward.circle", withConfiguration: configuration)
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
  
  func configureStackView() {
    view.addSubview(stackView)
    
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 36
    
    stackView.addArrangedSubview(stopButton)
    stackView.addArrangedSubview(pauseButton)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250)
    ])
  }
  
  func configureStopButton() {
    stopButton.alpha = 0
    stopButton.addTarget(self, action: #selector(stopCountdown), for: .touchUpInside)
    
    if #available(iOS 13.0, *) {
      let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 44))
      let stopSymbol = UIImage(systemName: "stop.circle", withConfiguration: configuration)
      stopButton.setImage(stopSymbol, for: .normal)
      stopButton.tintColor = steelBlue
    } else {
      stopButton.setTitle("Stop", for: .normal)
      stopButton.titleLabel?.font = .systemFont(ofSize: 28)
      stopButton.titleLabel?.textAlignment = .center
      stopButton.setTitleColor(opaqueSteelBlue, for: .normal)
    }
    
    stopButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stopButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
    ])
  }
  
  func configurePauseButton() {
    pauseButton.alpha = 0
    pauseButton.addTarget(self, action: #selector(pauseCountdown), for: .touchUpInside)
    
    if #available(iOS 13.0, *) {
      let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 44))
      let pauseSymbol = UIImage(systemName: "pause.circle", withConfiguration: configuration)
      pauseButton.setImage(pauseSymbol, for: .normal)
      pauseButton.tintColor = steelBlue
    } else {
      pauseButton.setTitle("Pause", for: .normal)
      pauseButton.titleLabel?.font = .systemFont(ofSize: 28)
      pauseButton.titleLabel?.textAlignment = .center
      pauseButton.setTitleColor(opaqueSteelBlue, for: .normal)
    }
    
    stopButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stopButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
    ])
  }
  
  
  @objc func changeButtonBackgroundColorWhenTouchUpInside(sender: UIButton) {
    sender.backgroundColor = darkCerulean
    sender.layer.shadowColor = romainSilver.cgColor
  }
  
  @objc func changeButtonBackgroundColorWhenReleased(sender: UIButton) {
    sender.backgroundColor = steelBlue
    sender.layer.shadowColor = coolGray.cgColor
  }
  
  // 處理剩餘時數為個位數或0的情形
  func unitDigitAdjusted(time: Int) -> String {
    if time != 0 {
      return time / 10 == 0 ? "0\(time)" : "\(time)"
    } else {
      return "00"
    }
  }
  
  @objc func startButtonPressed() {
    startCountdown()
    changeView()
  }
  
  func changeView() {
    // 開始計時後不可再修改時數
    timerTextField.isEnabled = false
    view.bringSubviewToFront(stackView)
    
    // 注意UIViewPropertyAnimator只能用於iOS 10以上版本
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
      self.backButton.alpha = 0
      self.startButton.alpha = 0
      
      self.stopButton.alpha = 1
      self.pauseButton.alpha = 1
    }
  }
  
  func startCountdown() {
    var totalSecLeft = totalSec
    
    //FIXME: - 好像會慢1~2秒才開始？這是正常的嗎？
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
      if totalSecLeft >= 0 {
        // 處理0或個位數的情形
        let minLeftLabel = self.unitDigitAdjusted(time: totalSecLeft / 60)
        let secLeftLabel = self.unitDigitAdjusted(time: totalSecLeft % 60)
        
        self.timerTextField.text = "\(minLeftLabel):\(secLeftLabel)"
        totalSecLeft -= 1
      } else {
        Timer.invalidate()
      }
    }
  }
  
  @objc func stopCountdown() {
    print("stop countdown")
  }
  
  @objc func pauseCountdown() {
    print("pause countdown")
  }
  
  //FIXME: - 目前在輸入時數超過上限的情況下，點返回鍵會先關閉視窗再關閉鍵盤，輸入未達上限的時候似乎不會有這情形
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
  
  //TODO: - 如何在不改變使用者輸入時間長的前提下，當超過120分鐘，點擊空白處會要求繼續輸入，點擊返回會收起鍵盤返回？
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    timeSet = Int(timerTextField.text!) ?? (state == .focusMode ? 25 : 5)
    
    // 若輸入時數超出上限，跳出提醒、自動重設為上限，並要求繼續輸入
    if (state == .focusMode && timeSet > focusLimit) || (state == .breakMode && timeSet > breakLimit) {
      let alert = UIAlertController(
        title: (state == .focusMode ? "為了讓你有適當的休息" : "休息太長會回不來"),
        message: "不能計時超過\(state == .focusMode ? focusLimit : breakLimit)分鐘喔！",
        preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      
      alert.addAction(okAction)
      present(alert, animated: true, completion: nil)
      
      timerTextField.text = String(state == .focusMode ? focusLimit : breakLimit)
      return false
    } else {
      return true
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    timerTextField.text = "\(unitDigitAdjusted(time: timeSet)):00"
  }
  
  // 點擊空白處收起鍵盤
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
