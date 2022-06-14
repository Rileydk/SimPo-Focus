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
  
  let culturedWhite = UIColor(red: 249/255, green: 247/255, blue: 247/255, alpha: 1)

  override func viewDidLoad() {
    super.viewDidLoad()

    print("It's time to \(state) on \(task)")
    // focus: It's time to focus on Your Task / It's time to focus on ...
    // break: It's time to take a break, for your Task
    
    self.view.backgroundColor = culturedWhite
  }
    

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
