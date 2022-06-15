//
//  timeBrain.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import Foundation

struct TimerBrain {
  var min = 0
  var sec = 0
  var totalSec: Int { self.min * 60 + self.sec }
  
  mutating func startTimer() {
    var secLeft = totalSec
    
    print("Set timer from \(min) minutes \(sec) seconds.")
    
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
