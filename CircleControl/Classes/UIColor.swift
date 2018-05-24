//
//  UIColor.swift
//  CircleControl
//
//  Created by Christian Moler on 06/04/2018.
//  Copyright © 2018 Christian Moler. All rights reserved.
//

import Foundation

extension UIColor {

  /**
   Returns the components that make up the color in the RGB color space as a tuple.
   
   - returns: The RGB components of the color or `nil` if the color could not be converted to RGBA color space.
   */
  private func getRGBAComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
    var (red, green, blue, alpha) = (CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0))
    if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      return (red, green, blue, alpha)
    } else {
      return nil
    }
  }

  func color(withPercentageDifference percentage: CGFloat) -> UIColor? {
    if let components = getRGBAComponents() {
      let redValue = components.red - components.red / 100 * percentage
      let greenValue = components.green - components.green / 100 * percentage
      let blueValue = components.blue - components.blue / 100 * percentage
      return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: components.alpha)
    } else {
      return nil
    }
  }

}
