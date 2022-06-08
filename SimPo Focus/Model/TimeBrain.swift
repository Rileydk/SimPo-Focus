//
//  timeBrain.swift
//  SimPo Focus
//
//  Created by Riley Lai on 2022/6/8.
//

import Foundation

struct TimeBrain {
  var min = 0
  var sec = 0
  var totalSec: Int { self.min * 60 + self.sec }
}
