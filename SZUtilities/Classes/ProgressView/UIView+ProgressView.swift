import UIKit

public enum ProgressViewLocation {
    case top, bottom
}

public extension UIView {
    public func szAddProgressBar(atLocation location: ProgressViewLocation,
                                 withStyle style: UIProgressViewStyle = .default,
                                 padding: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) -> UIProgressView {
        let progressBar = UIProgressView(progressViewStyle: style)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBar)

        var visualFormat: String!

        switch location {
        case .bottom:
            visualFormat = "V:[progressBar]-bottomPadding-|"
        case .top:
            visualFormat = "V:|-topPadding-[progressBar]"
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                                      options: NSLayoutFormatOptions(rawValue: 0),
                                                      metrics: ["topPadding": padding.top,
                                                                "bottomPadding": padding.bottom],
                                                      views: ["progressBar": progressBar]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-leftPadding-[progressBar]-rightPadding-|",
                                                      options: NSLayoutFormatOptions(rawValue: 0),
                                                      metrics: ["leftPadding": padding.left,
                                                                "rightPadding": padding.right],
                                                      views: ["progressBar": progressBar]))

        return progressBar

    }
}
