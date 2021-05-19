//
//  UITextField+PlaceHolder.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 20/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func textWithTrimmiedWhiteSpeace() -> String? {
        text = (text?.trimmingCharacters(in: CharacterSet.whitespaces))!
        return text
    }
    
}
