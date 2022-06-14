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
  
  var stateLabel = UILabel()
  var taskLabel = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // View
    self.view.backgroundColor = culturedWhite
    configureStateLabel()
    configureTaskLabel()
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

}
