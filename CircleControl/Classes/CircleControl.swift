//
//  CircleControl.swift
//  CircleControl
//
//  Created by Christian Moler on 06/04/2018.
//  Copyright © 2018 Christian Moler. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable

public class CircleControl: UIControl {

  public typealias ValueChangedСlosure = (CGFloat) -> Void

  // MARK: Private properties

  private weak var gradientLayer: CAGradientLayer!
  private weak var middleView: UIView!
  private weak var middleGradientLayer: CAGradientLayer!
  private weak var topLayer: UIView!
  private weak var holeGradientLayer: CAGradientLayer!
  private var midPoint: CGPoint!
  private var _angle: CGFloat = 0
  private var _previousAngle: CGFloat = 0
  private var _value: CGFloat = 0
  private let rotationMath = CircleRotationMath()

  // MARK: Public properties

  public var valueDidChanged: ValueChangedСlosure?
  public weak var delegate: CircleControlDelegate?
  @IBInspectable public var minimum: CGFloat = 0
  @IBInspectable public var maximum: CGFloat = 360
  @IBInspectable public var value: CGFloat = 0 {
    willSet {
      if newValue < minimum {
        _value = minimum
      } else if newValue > maximum {
        _value = maximum
      } else {
        _value = newValue
      }
    }
  }
  @IBInspectable public var stepInDegrees: CGFloat = 10
  @IBInspectable public var step: CGFloat = 1
  @IBInspectable public var mainColor: UIColor = .red {
    didSet {
      topLayer.backgroundColor = mainColor
      gradientLayer.colors = [mainColor.color(withPercentageDifference: -Constants.defaultGradientDifference)?.cgColor as Any, mainColor.color(withPercentageDifference: Constants.defaultGradientDifference)?.cgColor as Any]
      middleGradientLayer.colors = [mainColor.color(withPercentageDifference: -Constants.defaultGradientDifference)?.cgColor as Any, mainColor.color(withPercentageDifference: Constants.defaultGradientDifference)?.cgColor as Any]
      holeGradientLayer.colors = [mainColor.color(withPercentageDifference: -Constants.defaultGradientDifference)?.cgColor as Any, mainColor.color(withPercentageDifference: Constants.defaultGradientDifference)?.cgColor as Any]
    }
  }

  // MARK: Initializers

  public override init(frame: CGRect) {
    super.init(frame: frame)
    initializeConfigurate()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initializeConfigurate()
  }

  // MARK: Override

  override public func layoutSubviews() {
    gradientLayer.frame = bounds
    layer.masksToBounds = true
    layer.cornerRadius = bounds.width / 2
    let middleFrameInset = bounds.width * Constants.subviewsMultiplier / 2
    let middleFrameWidthHeight = bounds.width - bounds.width * Constants.subviewsMultiplier
    middleView.frame = CGRect(x: middleFrameInset, y: middleFrameInset, width: middleFrameWidthHeight, height: middleFrameWidthHeight)
    middleGradientLayer.frame = middleView.bounds
    middleGradientLayer.masksToBounds = true
    middleGradientLayer.cornerRadius = middleFrameWidthHeight / 2

    let topFrameInset = middleFrameWidthHeight * Constants.subviewsMultiplier / 2
    let topFrameWidthHeight = middleFrameWidthHeight - middleFrameWidthHeight * Constants.subviewsMultiplier
    topLayer.frame = CGRect(x: topFrameInset, y: topFrameInset, width: topFrameWidthHeight, height: topFrameWidthHeight)
    topLayer.layer.cornerRadius = topFrameWidthHeight / 2
    topLayer.layer.masksToBounds = true
    midPoint = CGPoint(x: topLayer.bounds.midX, y: topLayer.bounds.midY)

    let holeFrameWidthHeight: CGFloat = topFrameWidthHeight * Constants.holeMultiplier
    let holeLeftFrameInset = topFrameWidthHeight / 2 - holeFrameWidthHeight/2
    holeGradientLayer.frame = CGRect(x: holeLeftFrameInset, y: Constants.holeTopFrameInset, width: holeFrameWidthHeight, height: holeFrameWidthHeight)
    holeGradientLayer.masksToBounds = true
    holeGradientLayer.cornerRadius = holeFrameWidthHeight / 2

    layer.layoutIfNeeded()
  }

  override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    return topLayer.bounds.contains(topLayer.layer.convert(touch.location(in: self), from: gradientLayer))
  }

  override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let nowPoint = topLayer.layer.convert(touch.location(in: self), from: gradientLayer)
    let prevPoint = topLayer.layer.convert(touch.previousLocation(in: self), from: gradientLayer)
    let distance = rotationMath.distanceBetween(firstPoint: midPoint, secondPoint: nowPoint)
    guard topLayer.bounds.width/2/10 <= distance && distance <= topLayer.bounds.width/2 else { return false }
    var angle = rotationMath.angleBerweenLinesInDegrees(beginLineA: midPoint, endLineA: prevPoint, beginLineB: midPoint, endLineB: nowPoint)
    if angle > 180 {
      angle -= 360
    } else if angle < -180 {
      angle += 360
    }
    rotate(angle)
    return true
  }

}

// MARK: Private Methods

private extension CircleControl {

  func initializeConfigurate() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    self.gradientLayer = gradientLayer
    layer.addSublayer(gradientLayer)

    let middleView = UIView()
    middleView.isUserInteractionEnabled = false
    self.middleView = middleView
    let middleGradientLayer = CAGradientLayer()
    middleGradientLayer.startPoint = CGPoint(x: 1, y: 0)
    middleGradientLayer.endPoint = CGPoint(x: 0, y: 1)
    self.middleGradientLayer = middleGradientLayer
    middleView.layer.addSublayer(middleGradientLayer)
    addSubview(middleView)

    let topLayer = UIView()
    topLayer.isUserInteractionEnabled = false
    middleView.addSubview(topLayer)
    self.topLayer = topLayer

    let holeGradientLayer = CAGradientLayer()
    holeGradientLayer.startPoint = CGPoint(x: 1, y: 0)
    holeGradientLayer.endPoint = CGPoint(x: 0, y: 1)
    self.holeGradientLayer = holeGradientLayer
    topLayer.layer.addSublayer(holeGradientLayer)

    layoutIfNeeded()
  }

  func rotate(_ angle: CGFloat) {
    _angle += angle
    if _angle > 360 {
      _angle -= 360
    } else if _angle < -360 {
      _angle += 360
    }
    topLayer.transform = CGAffineTransform(rotationAngle: _angle * .pi / 180)
    guard _previousAngle < _angle - stepInDegrees || _previousAngle > _angle + stepInDegrees else { return }
    _previousAngle = _angle
    if _value >= minimum && _value <= maximum {
      if (_value == minimum && angle < 0) || (_value == maximum && angle > 0 ) {
        return
      }
      value = angle < 0 ? _value - step : _value + step
      sendActions(for: .valueChanged)
      delegate?.valueDidChanged(value)
      valueDidChanged?(value)
    }
  }

}

// MARK: Nested

private extension CircleControl {

  struct Constants {
    static let subviewsMultiplier: CGFloat = 0.1
    static let holeMultiplier: CGFloat = 0.12
    static let holeTopFrameInset: CGFloat = 10
    static let defaultGradientDifference: CGFloat = 40
  }

}
