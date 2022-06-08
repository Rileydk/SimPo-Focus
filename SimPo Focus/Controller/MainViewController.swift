//
//  ViewController.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import UIKit

class MainViewController: UIViewController {
  
  var timeBrain = TimeBrain()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Start countdown
    timeBrain.min = 1
    timeBrain.sec = 15
    timer()
  }
  
  func timer() {
    var secLeft = timeBrain.totalSec
    
    print("Set timer from \(timeBrain.min) minutes \(timeBrain.sec) seconds.")
    
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
      if secLeft > 0 {
        print("\(secLeft / 60) minutes \(secLeft % 60) left")
        secLeft -= 1
      } else {
        print("End countdown")
        Timer.invalidate()
      }
    }
  }

}

