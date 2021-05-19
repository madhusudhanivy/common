//
//  UIView+CalculateHeight.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 19/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import UIKit

extension UIView {
    @objc func estimatedHeight() -> CGFloat {
        return systemLayoutSizeFitting(CGSize(width: frame.width, height: 0),
                                       withHorizontalFittingPriority: .required,
                                       verticalFittingPriority: .fittingSizeLevel).height
    }
}
