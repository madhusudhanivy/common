//
//  UIStoryboard+Extensions.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 19/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    private enum Name: String {
        case main = "Main"
        case tabBar = "TabBar"
    }

    static var main: UIStoryboard { return  .named(.main) }
    static var tabBar: UIStoryboard { return  .named(.tabBar) }

    // MARK: Methods

    private static func named(_ name: Name, prebranded: Bool = false) -> UIStoryboard {
        let storyboardName = name.rawValue

        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}
