public extension UIView {
    @discardableResult public func szBeginPulsing(withToValue toValue: NSNumber) -> CABasicAnimation {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.0
        animation.toValue = toValue
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = FLT_MAX
        layer.add(animation, forKey: "szPulseAnimation")

        return animation
    }

    public func szEndPulsing() {
        layer.removeAnimation(forKey: "szPulseAnimation")
    }
}
