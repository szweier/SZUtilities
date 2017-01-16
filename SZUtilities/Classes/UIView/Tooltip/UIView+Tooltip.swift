import UIKit

public enum ArrowPosition {
    case top, left, bottom, right
}

public extension UIView {
    public func szPointAt(_ item: UIView, position: ArrowPosition, backgroundColor: UIColor = .white, borderColor: UIColor = .black) {

        let point = item.center

        // Get Height and Width
        let arrowHeight: CGFloat = 10.0
        let arrowWidth: CGFloat = 10.0

        let layerHeight = bounds.size.height - 1
        let layerWidth = bounds.size.width - 1

        var arrowPosition = position
        guard let superview = superview else { return }

        if arrowPosition == .left {
            let xPointMax = point.x + layerWidth / 2

            if xPointMax > superview.frame.size.width {
                NSLog("Arrow position is set to left but location to point at does not allow this, adjusting arrow position to right")
                arrowPosition = .right
            }
        }
        else if arrowPosition == .right {
            let xPointMin = point.x - layerWidth / 2

            if xPointMin < 0 {
                NSLog("Arrow position is set to right but location to point at does not allow this, adjusting arrow position to left")
                arrowPosition = .left
            }
        }
        else if arrowPosition == .top {
            let yPointMax = point.y + layerHeight / 2

            if yPointMax > superview.frame.size.height {
                NSLog("Arrow position is set to top but location to point at does not allow this, adjusting arrow position to bottom")
                arrowPosition = .bottom
            }
        }
        else if arrowPosition == .bottom {
            let yPointMin = point.y - layerHeight / 2

            if yPointMin < 0 {
                NSLog("Arrow position is set to bottom but location to point at does not allow this, adjusting arrow position to top")
                arrowPosition = .top
            }
        }

        // Create Path
        let arrowPath = CGMutablePath()

        // Draw Points
        arrowPath.move(to: CGPoint(x: 0, y: arrowHeight))
        arrowPath.addLine(to: CGPoint(x: arrowWidth, y: arrowHeight))
        arrowPath.addLine(to: CGPoint(x: arrowWidth / 2, y: 0))
        arrowPath.addLine(to: CGPoint(x: 0, y: arrowHeight))

        // Apply Color
        UIColor.green.setFill()

        // Mask to Path
        let arrowShape = CAShapeLayer()
        arrowShape.path = arrowPath
        arrowShape.lineWidth = 1.0
        arrowShape.strokeColor = borderColor.cgColor
        arrowShape.fillColor = backgroundColor.cgColor
        arrowShape.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        var rotation: Double

        switch arrowPosition {
        case .top:
            rotation = 0
            arrowShape.frame = CGRect(x: layerWidth / 2 - arrowWidth / 2, y: 0, width: arrowWidth, height: arrowHeight)
        case .bottom:
            rotation = 180 * M_PI/180
            arrowShape.frame = CGRect(x: layerWidth / 2 - arrowWidth / 2, y: layerHeight, width: arrowWidth, height: arrowHeight)
        case .left:
            rotation = -(90 * M_PI/180)
            arrowShape.frame = CGRect(x: -arrowWidth, y: layerHeight / 2 - arrowWidth / 2, width: arrowWidth, height: arrowHeight)
        case .right:
            rotation = 90 * M_PI/180
            arrowShape.frame = CGRect(x: layerWidth, y: layerHeight / 2 - arrowWidth / 2, width: arrowWidth, height: arrowHeight)
        }
        arrowShape.transform = CATransform3DMakeRotation(CGFloat(rotation), 0, 0, 1.0)

        layer.insertSublayer(arrowShape, at: 0)

        // Create Path
        let bezierPath = CGMutablePath()

        // Draw Points
        bezierPath.move(to: CGPoint(x: 0, y: layerHeight))
        bezierPath.addLine(to: CGPoint(x: layerWidth, y: layerHeight))
        bezierPath.addLine(to: CGPoint(x: layerWidth, y: 10))
        bezierPath.addLine(to: CGPoint(x: 0, y: 10))
        bezierPath.addLine(to: CGPoint(x: 0, y: layerHeight))

        // Apply Color
        UIColor.green.setFill()

        // Mask to Path
        let shape = CAShapeLayer()
        shape.path = bezierPath
        shape.lineWidth = 1.0
        shape.strokeColor = borderColor.cgColor
        shape.fillColor = backgroundColor.cgColor

        layer.insertSublayer(shape, above: arrowShape)

        self.backgroundColor = .clear

        if arrowPosition == .top {
            let xPointMin = point.x - layerWidth / 2
            let xPointMax = point.x + layerWidth / 2

            if xPointMin > 0, xPointMax < superview.frame.size.width {
                frame = CGRect(x: point.x - layerWidth / 2, y: point.y, width: frame.size.width, height: frame.size.height)
            } else if xPointMin < 0 {
                frame = CGRect(x: 0, y: point.y, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: point.x - arrowWidth / 2, y: 0, width: arrowWidth, height: arrowHeight)
            } else if xPointMax > superview.frame.size.width {
                frame = CGRect(x: superview.frame.size.width - layerWidth, y: point.y, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: (layerWidth - arrowWidth / 2) - (superview.frame.size.width - point.x), y: 0, width: arrowWidth, height: arrowHeight)
            }
        }
        else if arrowPosition == .bottom {
            let xPointMin = point.x - layerWidth / 2
            let xPointMax = point.x + layerWidth / 2

            if xPointMin > 0, xPointMax < superview.frame.size.width {
                frame = CGRect(x: point.x - layerWidth / 2, y: point.y - layerHeight - arrowHeight / 2, width: frame.size.width, height: frame.size.height)
            } else if xPointMin < 0 {
                frame = CGRect(x: 0, y: point.y - layerHeight - arrowHeight / 2, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: point.x - arrowWidth / 2, y: layerHeight, width: arrowWidth, height: arrowHeight)
            } else if xPointMax > superview.frame.size.width {
                frame = CGRect(x: superview.frame.size.width - layerWidth, y: point.y - layerHeight - arrowHeight / 2, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: (layerWidth - arrowWidth / 2) - (superview.frame.size.width - point.x), y: layerHeight, width: arrowWidth, height: arrowHeight)
            }
        }
        else if arrowPosition == .left {
            let yPointMin = point.y - layerHeight / 2
            let yPointMax = point.y + layerHeight / 2

            if yPointMin > 0, yPointMax < superview.frame.size.height {
                frame = CGRect(x: point.x + arrowWidth, y: point.y - layerHeight / 2, width: frame.size.width, height: frame.size.height)
            } else if yPointMin < 0 {
                frame = CGRect(x: point.x + arrowWidth, y: 0, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: -arrowWidth, y: point.y - arrowHeight / 2, width: arrowWidth, height: arrowHeight)
            } else if yPointMax > superview.frame.size.width {
                frame = CGRect(x: point.x + arrowWidth, y: superview.frame.size.height - layerHeight, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: -arrowWidth, y: (layerHeight - arrowHeight / 2) - (superview.frame.size.height - point.y), width: arrowWidth, height: arrowHeight)
            }
        }
        else if arrowPosition == .right {
            let yPointMin = point.y - layerHeight / 2
            let yPointMax = point.y + layerHeight / 2

            if yPointMin > 0, yPointMax < superview.frame.size.height {
                frame = CGRect(x: point.x - layerWidth - arrowWidth / 2, y: point.y - layerHeight / 2, width: frame.size.width, height: frame.size.height)
            } else if yPointMin < 0 {
                frame = CGRect(x: point.x - layerWidth - arrowWidth / 2, y: 0, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: layerWidth, y: point.y - arrowHeight / 2, width: arrowWidth, height: arrowHeight)
            } else if yPointMax > superview.frame.size.width {
                frame = CGRect(x: point.x - layerWidth - arrowWidth / 2, y: superview.frame.size.height - layerHeight, width: frame.size.width, height: frame.size.height)
                arrowShape.frame = CGRect(x: layerWidth, y: (layerHeight - arrowHeight / 2) - (superview.frame.size.height - point.y), width: arrowWidth, height: arrowHeight)
            }
        }
    }
}
