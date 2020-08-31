//
//  CircularProgress.swift
//  Driva
//
//  Created by iDeveloper on 10.08.2018.
//  Copyright © 2018 Charlyn Keating Media LLC. All rights reserved.
//

import UIKit

private extension Comparable {
  func clamped(toMinimum minimum: Self, maximum: Self) -> Self {
    assert(maximum >= minimum, "Maximum clamp value can't be higher than the minimum")
    if self < minimum {
      return minimum
    } else if self > maximum {
      return maximum
    } else {
      return self
    }
  }
}

@IBDesignable
public class CircularProgress: UIView, CAAnimationDelegate {
  private enum Conversion {
    static func degreesToRadians (value:CGFloat) -> CGFloat {
      return value * .pi / 180.0
    }
  }
  
  private enum Utility {
    
    static func mod(value: Double, range: Double, minMax: (Double, Double)) -> Double {
      let (min, max) = minMax
      assert(abs(range) <= abs(max - min), "range should be <= than the interval")
      if value >= min && value <= max {
        return value
      } else if value < min {
        return mod(value: value + range, range: range, minMax: minMax)
      } else {
        return mod(value: value - range, range: range, minMax: minMax)
      }
    }
  }
  
  private var progressLayer: CircularProgressViewLayer {
    get {
      return layer as! CircularProgressViewLayer
    }
  }
  
  private var radius: CGFloat = 0 {
    didSet {
      progressLayer.radius = radius
    }
  }
  
  public var progress: Double = 0 {
    didSet {
      let clampedProgress = progress.clamped(toMinimum: 0, maximum: 1)
      angle = 360 * clampedProgress
    }
  }
  
  @IBInspectable public var angle: Double = 0 {
    didSet {
      if self.isAnimating() {
        self.pauseAnimation()
      }
      progressLayer.angle = angle
    }
  }
  
  @IBInspectable public var startAngle: Double = 0 {
    didSet {
      startAngle = Utility.mod(value: startAngle, range: 360, minMax: (0, 360))
      progressLayer.startAngle = startAngle
      progressLayer.setNeedsDisplay()
    }
  }
  
  @IBInspectable public var clockwise: Bool = true {
    didSet {
      progressLayer.clockwise = clockwise
      progressLayer.setNeedsDisplay()
    }
  }
  
  @IBInspectable public var progressThickness: CGFloat = 0.4 {//Between 0 and 1
    didSet {
      progressThickness = progressThickness.clamped(toMinimum: 0, maximum: 1)
      progressLayer.progressThickness = progressThickness / 2
    }
  }
  
  @IBInspectable public var trackThickness: CGFloat = 0.5 {//Between 0 and 1
    didSet {
      trackThickness = trackThickness.clamped(toMinimum: 0, maximum: 1)
      progressLayer.trackThickness = trackThickness / 2
    }
  }
  
  @IBInspectable public var trackColor: UIColor = .black {
    didSet {
      progressLayer.trackColor = trackColor
      progressLayer.setNeedsDisplay()
    }
  }
  
  @IBInspectable public var progressInsideFillColor: UIColor? = nil {
    didSet {
      progressLayer.progressInsideFillColor = progressInsideFillColor ?? .clear
    }
  }
  
  public var progressColor: UIColor {
    get { return progressLayer.color }
    set { set(color: newValue) }
  }
  
  ///These are used only from the Interface-Builder. Changing these from code will have no effect.
  @objc @IBInspectable private var IBColor: UIColor?
  
  private var animationCompletionBlock: ((Bool) -> Void)?
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setInitialValues()
    refreshValues()
    checkAndSetIBColors()
  }
  
  convenience public init(frame:CGRect, color: UIColor) {
    self.init(frame: frame)
    set(color: color)
  }
  
  required public init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    translatesAutoresizingMaskIntoConstraints = false
    setInitialValues()
    refreshValues()
  }
  
  public override func awakeFromNib() {
    checkAndSetIBColors()
  }
  
  override public class var layerClass: AnyClass {
    return CircularProgressViewLayer.self
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    radius = frame.size.width / 2.0
  }
  
  private func setInitialValues() {
    radius = frame.size.width / 2.0 //We always apply a 20% padding, stopping glows from being clipped
    backgroundColor = .clear
    set(color: .cyan)
  }
  
  private func refreshValues() {
    progressLayer.angle = angle
    progressLayer.startAngle = startAngle
    progressLayer.clockwise = clockwise
    progressLayer.progressThickness = progressThickness / 2
    progressLayer.trackColor = trackColor
    progressLayer.trackThickness = trackThickness / 2
  }
  
  private func checkAndSetIBColors() {
    if let nonNilColor = IBColor {
      set(color: nonNilColor)
    }
  }
  
  public func set(color: UIColor) {
    progressLayer.color = color
    progressLayer.setNeedsDisplay()
  }
  
  public func animate(fromAngle: Double, toAngle: Double, duration: TimeInterval, relativeDuration: Bool = true, completion: ((Bool) -> Void)?) {
    if isAnimating() {
      pauseAnimation()
    }
    
    let animationDuration: TimeInterval
    if relativeDuration {
      animationDuration = duration
    } else {
      let traveledAngle = Utility.mod(value: toAngle - fromAngle, range: 360, minMax: (0, 360))
      let scaledDuration = (TimeInterval(traveledAngle) * duration) / 360
      animationDuration = scaledDuration
    }
    
    let animation = CABasicAnimation(keyPath: "angle")
    animation.fromValue = fromAngle
    animation.toValue = toAngle
    animation.duration = animationDuration
    animation.delegate = self
    animation.isRemovedOnCompletion = false
    angle = toAngle
    animationCompletionBlock = completion
    
    progressLayer.add(animation, forKey: "angle")
  }
  
  public func animate(toAngle: Double, duration: TimeInterval, relativeDuration: Bool = true, completion: ((Bool) -> Void)?) {
    if isAnimating() {
      pauseAnimation()
    }
    animate(fromAngle: angle, toAngle: toAngle, duration: duration, relativeDuration: relativeDuration, completion: completion)
  }
  
  public func pauseAnimation() {
    guard let presentationLayer = progressLayer.presentation() else { return }
    
    let currentValue = presentationLayer.angle
    progressLayer.removeAllAnimations()
    angle = currentValue
  }
  
  public func stopAnimation() {
    progressLayer.removeAllAnimations()
    angle = 0
  }
  
  public func isAnimating() -> Bool {
    return progressLayer.animation(forKey: "angle") != nil
  }
  
  public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if let completionBlock = animationCompletionBlock {
      animationCompletionBlock = nil
      completionBlock(flag)
    }
  }
  
  public override func didMoveToWindow() {
    if let window = window {
      progressLayer.contentsScale = window.screen.scale
    }
  }
  
  public override func willMove(toSuperview newSuperview: UIView?) {
    if newSuperview == nil && isAnimating() {
      pauseAnimation()
    }
  }
  
  public override func prepareForInterfaceBuilder() {
    setInitialValues()
    refreshValues()
    checkAndSetIBColors()
    progressLayer.setNeedsDisplay()
  }
  
  //MARK: - CircularProgressViewLayer
  private class CircularProgressViewLayer: CALayer {
    @NSManaged var angle: Double
    var radius: CGFloat = 0
    var startAngle: Double = 0
    var clockwise: Bool = true
    var progressThickness: CGFloat = 0.5
    var trackThickness: CGFloat = 0.5
    var trackColor: UIColor = .black
    var progressInsideFillColor: UIColor = .clear
    var color: UIColor = .white
    private var locationsCache: [CGFloat]?
    
    override class func needsDisplay(forKey key: String) -> Bool {
      return key == "angle" ? true : super.needsDisplay(forKey: key)
    }
    
    override init(layer: Any) {
      super.init(layer: layer)
      let progressLayer = layer as! CircularProgressViewLayer
      radius = progressLayer.radius
      angle = progressLayer.angle
      startAngle = progressLayer.startAngle
      clockwise = progressLayer.clockwise
      progressThickness = progressLayer.progressThickness
      trackThickness = progressLayer.trackThickness
      trackColor = progressLayer.trackColor
      color = progressLayer.color
      progressInsideFillColor = progressLayer.progressInsideFillColor
    }
    
    override init() {
      super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    override func draw(in ctx: CGContext) {
      UIGraphicsPushContext(ctx)
      
      let size = bounds.size
      let width = size.width
      let height = size.height
      
      let trackLineWidth = radius * trackThickness
      let progressLineWidth = radius * progressThickness
      let arcRadius = max(radius - trackLineWidth / 2, radius - progressLineWidth / 2)
      ctx.addArc(center: CGPoint(x: width / 2.0, y: height / 2.0), radius: arcRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
      trackColor.set()
      ctx.setStrokeColor(trackColor.cgColor)
      ctx.setFillColor(progressInsideFillColor.cgColor)
      ctx.setLineWidth(trackLineWidth)
      ctx.setLineCap(CGLineCap.butt)
      ctx.drawPath(using: .fillStroke)
      
      UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
      
      let imageCtx = UIGraphicsGetCurrentContext()
      let reducedAngle = Utility.mod(value: angle, range: 360, minMax: (0, 360))
      let fromAngle = Conversion.degreesToRadians(value: CGFloat(-startAngle))
      let toAngle = Conversion.degreesToRadians(value: CGFloat((clockwise == true ? -reducedAngle : reducedAngle) - startAngle))
      
      imageCtx?.addArc(center: CGPoint(x: width / 2.0, y: height / 2.0), radius: arcRadius, startAngle: fromAngle, endAngle: toAngle, clockwise: clockwise)
      
      let linecap: CGLineCap = .butt
      imageCtx?.setLineCap(linecap)
      imageCtx?.setLineWidth(progressLineWidth)
      imageCtx?.drawPath(using: .stroke)
      
      let drawMask: CGImage = UIGraphicsGetCurrentContext()!.makeImage()!
      UIGraphicsEndImageContext()
      
      ctx.saveGState()
      ctx.clip(to: bounds, mask: drawMask)
      
      fillRectWith(context: ctx, color: color)
      
      ctx.restoreGState()
      UIGraphicsPopContext()
    }
    
    private func fillRectWith(context: CGContext!, color: UIColor) {
      context.setFillColor(color.cgColor)
      context.fill(bounds)
    }
  }
}
