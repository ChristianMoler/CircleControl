//
//  ViewController.swift
//  CircleControlDemo
//
//  Created by Christian Moler on 02/04/2018.
//  Copyright © 2018 Christian Moler. All rights reserved.
//

import UIKit
import CircleControl

class ViewController: UIViewController {

  @IBOutlet weak var circleControl: CircleControl!
  @IBOutlet weak var label: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    circleControl.delegate = self
    circleControl.addTarget(self, action: #selector(circleValueChanged), for: .valueChanged)
    circleControl.valueDidChanged = { value in
      print("closure \(value)")
    }
  }

  @objc func circleValueChanged(circleControl: CircleControl) {
    label.text = "\(circleControl.value)"
  }

}

extension ViewController: CircleControlDelegate {
  func valueDidChanged(_ value: CGFloat) {
    print("delegate \(value)")
  }


}
