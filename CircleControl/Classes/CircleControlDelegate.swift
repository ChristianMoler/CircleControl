//
//  CircleControlDelegate.swift
//  CircleControl
//
//  Created by Christian Moler on 23/05/2018.
//  Copyright © 2018 Christian Moler. All rights reserved.
//

import Foundation

public protocol CircleControlDelegate: class {

  func valueDidChanged(_ value: CGFloat)

}
