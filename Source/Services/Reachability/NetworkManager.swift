//
//  NetworkManager.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 03/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit
import Reachability

internal final class NetworkManager {
    
    static let shared = NetworkManager()
    
    var reachability: Reachability?

    var netAvailability = false
        
    @objc func configureReachability() {
        
        stopNotifier()

        reachability = Reachability()
                    
        /* For find out Internet when goes On or Off
         */
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability!.startNotifier()
        }catch{
          print("could not start reachability notifier")
        }
        
    }
    
    func stopNotifier() {
        if reachability != nil { reachability!.stopNotifier() }
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    //MARK: - Network Finder
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            netAvailability = true
            internetConnectionAvailble()
        case .cellular:
            netAvailability = true
            internetConnectionAvailble()
        case .none:
            netAvailability = false
        }
        
    }
        
    func internetConnectionNotAvailble(viewController: UIViewController) {
        AlertManager.shared.confirmationAlert(title: "Internet connection not available", message: "Please click on Reconnect for internet connection or Click cancel to close the application", buttonTitle: "Reconnect", controller: viewController) { (_) in
            self.configureReachability()
        }
    }
    
    func internetConnectionAvailble() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.configureReachability()
        }
    }
    
}
