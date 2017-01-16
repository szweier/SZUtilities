import UIKit

public extension UIView {
    public func szAddCornerRadius(_ radius: CGFloat, toCorners corners: UIRectCorner) {
        //Current height is ignored (likely Apple bug) see: http://stackoverflow.com/questions/18880919/why-is-cornerradii-parameter-of-cgsize-type-in-uibezierpath-bezierpathwithroun
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path  = maskPath.cgPath
        layer.mask = maskLayer
    }
}
