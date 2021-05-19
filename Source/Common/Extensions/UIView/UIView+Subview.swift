//
//  UIView+Subview.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 19/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds a subview that takes full size of the receiver and applies layout constraints to follow the receiver size.
    /// - Parameter subview: Subview to add.
    /// - Parameter respectLanguageDirection: Defines whether added constraints should respect language direction.
    func addFullSizeSubview(_ subview: UIView, respectLanguageDirection: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false

        subview.frame = bounds
        addSubview(subview)

        let views = ["subview": subview]
        let layoutFormatOptions: NSLayoutConstraint.FormatOptions
        layoutFormatOptions = respectLanguageDirection ? .directionLeadingToTrailing : .directionLeftToRight

        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|",
                                                                   options: layoutFormatOptions,
                                                                   metrics: nil,
                                                                   views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|",
                                                                 options: layoutFormatOptions,
                                                                 metrics: nil,
                                                                 views: views)

        (horizontalConstraints + verticalConstraints).forEach { $0.isActive = true }
    }
    
}
