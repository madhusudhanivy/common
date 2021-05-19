//
//  UIDevice+DeviceInfo.swift
//  Melu
//
//  Created by apple on 07/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit

public struct Device {
    
    // MARK: - Singletons
    public static var CurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    public static var CurrentDeviceWidth: CGFloat {
        struct Singleton {
            static let width = UIScreen.main.bounds.size.width
        }
        return Singleton.width
    }
    
    public static var CurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.main.bounds.size.height
        }
        return Singleton.height
    }
    
    // MARK: - Device Idiom Checks
    
    public static func isPhone() -> Bool {
        return CurrentDevice.userInterfaceIdiom == .phone
    }
    
    public static func hasTopNotch() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // with notch: 44.0 on iPhone X, XS, XS Max, XR.
            // without notch: 24.0 on iPad Pro 12.9" 3rd generation, 20.0 on iPhone 8 on iOS 12+.
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        }
        return false
    }

    // MARK: - Device Size Checks
    public enum Widths: CGFloat {
        case Inches_4 = 320
        case Inches_4_7 = 375
        case Inches_5_5 = 414
    }
    
    public enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }
    
    public static func isSize(height: Heights) -> Bool {
        return CurrentDeviceHeight == height.rawValue
    }
    
    public static var CURRENT_SIZE: String {
        if IS_3_5_INCHES() {
            return "3.5 Inches"
        } else if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(CurrentDeviceHeight) Points"
    }
    
    // MARK: 3.5 Inch Checks
    public static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_3_5)
    }
    
    // MARK: 4 Inch Checks
    public static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_4)
    }
    
    // MARK: 4.7 Inch Checks
    public static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_4_7)
    }
    
    // MARK: 5.5 Inch Checks
    public static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_5_5)
    }
    
}
