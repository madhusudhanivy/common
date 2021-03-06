//
//  ActivityIndicator.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 04/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import MBProgressHUD

public final class ActivityIndicator {
    
    public static let shared = ActivityIndicator()
    
    // MARK: -
    /// Method for showing activity indicator.
    public func showActivity(viewController: UIViewController) {
        
        DispatchQueue.main.async(execute: {
            MBProgressHUD.showAdded(to: viewController.view, animated: true)
            viewController.view.bringSubviewToFront(MBProgressHUD())
        })
        
    }

    /// Method for hiding activity indicator.
    public func hideActivity(viewController: UIViewController) {
        
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: viewController.view, animated: false)
        })
    }
    
}
