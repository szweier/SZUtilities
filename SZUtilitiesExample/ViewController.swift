//
//  ViewController.swift
//  SZUtilitiesExample
//
//  Created by Steven Zweier on 1/11/17.
//  Copyright © 2017 Steven Zweier. All rights reserved.
//

import UIKit
import SZUtilities

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let progressView = view.szAddProgressBar(atLocation: .bottom, padding: UIEdgeInsetsMake(0, 20, 20, 20))
        progressView.trackTintColor = .red
        progressView.progressTintColor = .blue
        progressView.setProgress(0.35, animated: true)

        let viewToPointAt = UIView()
        viewToPointAt.frame = CGRect(x: 100, y: 100, width: 25, height: 25)
        viewToPointAt.backgroundColor = .blue
        viewToPointAt.layer.cornerRadius = 12.5
        view.addSubview(viewToPointAt)
        viewToPointAt.szMakeMovable()
        viewToPointAt.szBeginPulsing(withToValue: 0.5)
        

        let testView = UIView()
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This is a test string to see how the tooltip ends up looking"
        testView.bounds = CGRect(x: 0, y: 0, width: 200, height: 100)
        label.frame = testView.bounds
//        testView.szAddCornerRadius(20, toCorners: [.bottomLeft, .topRight])
        view.addSubview(testView)
        testView.addSubview(label)

        testView.szPointAt(viewToPointAt, position: .left, backgroundColor: .white, borderColor: .black)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            viewToPointAt.szEndPulsing()
        }
    }
}

