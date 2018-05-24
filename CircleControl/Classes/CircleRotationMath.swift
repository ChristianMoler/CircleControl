//
//  CircleRotationMath.swift
//  CircleControl
//
//  Created by Christian Moler on 23/05/2018.
//  Copyright © 2018 Christian Moler. All rights reserved.
//

import Foundation

struct CircleRotationMath {


  func distanceBetween(firstPoint: CGPoint, secondPoint: CGPoint) -> CGFloat {
    let dx = firstPoint.x - secondPoint.x
    let dy = firstPoint.y - secondPoint.y
    return sqrt(dx*dx + dy*dy)
  }

  func angleBerweenLinesInDegrees(beginLineA: CGPoint, endLineA: CGPoint, beginLineB: CGPoint, endLineB: CGPoint) -> CGFloat {
    let a = endLineA.x - beginLineA.x
    let b = endLineA.y - beginLineA.y
    let c = endLineB.x - beginLineB.x
    let d = endLineB.y - beginLineB.y
    let atanA = atan2(a, b)
    let atanB = atan2(c, d)
    return (atanA - atanB) * 180 / .pi
  }

}
