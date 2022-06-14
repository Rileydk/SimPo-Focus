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
  
  let steelBlue = UIColor(red: 63/255, green: 114/255, blue: 175/255, alpha: 1)
  let culturedWhite = UIColor(red: 249/255, green: 247/255, blue: 247/255, alpha: 1)

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // View
    self.view.backgroundColor = culturedWhite
    configureStateLabel()
  }
    
  func configureStateLabel() {
    view.addSubview(stateLabel)
    
    stateLabel.text = state
    stateLabel.accessibilityLabel = state
    stateLabel.font = .boldSystemFont(ofSize: 46)
    stateLabel.textColor = steelBlue
    stateLabel.textAlignment = .center
    
    stateLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
      stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

}
