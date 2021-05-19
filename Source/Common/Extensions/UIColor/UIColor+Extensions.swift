//
//  UIColor+Extensions.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 20/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: r.cgFloatValue / 255.0,
                  green: g.cgFloatValue / 255.0,
                  blue: b.cgFloatValue / 255.0,
                  alpha: alpha)
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(r: rgb, g: rgb, b: rgb, alpha: alpha)
    }

    static func dynamicColor(name: String, color: UIColor) -> UIColor {
        guard #available(iOS 11.0, *) else {
            return color
        }

        return UIColor(named: name) ?? color
    }
}

extension UIColor {
        
    static var background: UIColor {
        UIColor.dynamicColor(name: "background",
                             color: UIColor(r: 241, g: 241, b: 241))
    }
    
    static var background1: UIColor {
        UIColor.dynamicColor(name: "background1",
                             color: UIColor(r: 236, g: 240, b: 241))
    }
    
    static var appColor: UIColor {
        UIColor.dynamicColor(name: "appColor",
                             color: UIColor(r: 30, g: 51, b: 64))
    }
    
    static var tabSelectedColor: UIColor {
        UIColor.dynamicColor(name: "tabSelectedColor",
                             color: UIColor(r: 237, g: 240, b: 241))
    }
    
    static var textColor1: UIColor {
        UIColor.dynamicColor(name: "textColor1",
                             color: UIColor(r: 119, g: 119, b: 119))
    }
    
    static var textColor2: UIColor {
        UIColor.dynamicColor(name: "textColor2", color: UIColor(r: 68, g: 68, b: 68))
    }
    
    static var borderColor: UIColor {
        UIColor.dynamicColor(name: "borderColor", color: UIColor(r: 236, g: 236, b: 236))
    }
    
    static var orangeColor: UIColor {
        UIColor.dynamicColor(name: "orangeColor", color: UIColor(r: 231, g: 76, b: 60))
    }
    
    static var yellowColor: UIColor {
        UIColor.dynamicColor(name: "yellowColor",
                             color: UIColor(r: 241, g: 196, b: 15))
    }
    
    public class func hexCode(_ hexString: String) -> UIColor {
        
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start]) // Swift 4 //hexString.substring(from: start)
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
                    a = CGFloat(1)
                    
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        
        return UIColor.black
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
}
