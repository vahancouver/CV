//
//  UIViewExtensions.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-09.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//
import UIKit

extension UIView {
    func bindFrameToSuperviewBounds(constant: CGFloat = 0.0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
            ]
        )
        
    }
    
    func addConstraintsWith(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        addConstraints([heightConstraint, widthConstraint])
    
    }
}
