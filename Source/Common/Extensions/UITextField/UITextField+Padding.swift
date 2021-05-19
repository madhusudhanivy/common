//
//  UITextField+Padding.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 20/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable var paddingLeft: CGFloat {
        get {
            return (leftView?.frame.width)!
        }
        set {
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 0))
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRight: CGFloat {
        get {
            return (rightView?.frame.width)!
        }
        set {
            self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 0))
            rightViewMode = .always
        }
    }
    
}
