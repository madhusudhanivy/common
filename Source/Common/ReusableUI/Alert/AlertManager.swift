//
//  AlertManager.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 02/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

internal final class AlertManager {
    
    static let shared = AlertManager()
    private var presenter: UIViewController?

    @objc func displayValidationAlert(title: String = "Alert", message: String, buttonTitle: String = "Dismiss", controller: UIViewController) {
        
        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle, style: .default) { (alertButtonAction) in
            self.presenter?.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(cancelAction)
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
        
    @objc func displaySuccessAlert(title: String = "Alert", message: String, buttonTitle: String = "Ok", controller: UIViewController, completionHandler: @escaping (_ data: Any) -> Void) {
        
        controller.view.endEditing(true)

        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle, style: .cancel) { (action) in
            
            DispatchQueue.main.async {
                completionHandler("we finished!")
            }
            
        }
        alertViewController.addAction(cancelAction)
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    @objc func confirmationAlert(title: String = "Alert", message: String, buttonTitle: String = "Ok", controller: UIViewController, completionHandler: @escaping (_ data: Any) -> Void) {
        
        controller.view.endEditing(true)

        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle == "Yes" ? "No" : "Cancel", style: .cancel) { (_) in
            
            if title == "Internet connection not available" || title == "Location Disabled" {
                exit(0)
            }
            
        }
        alertViewController.addAction(cancelAction)
        
        let cinformAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            
            DispatchQueue.main.async {
                completionHandler("we finished!")
            }
            
        }
        alertViewController.addAction(cinformAction)
        
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    @objc func alertWithOutAction(title: String = "Warning", message: String, buttonTitle: String = "Ok", controller: UIViewController) {
        
        controller.view.endEditing(true)

        presenter = controller
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cinformAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in

            DispatchQueue.main.async {
                
            }

        }
        alertViewController.addAction(cinformAction)
        
        presenter?.present(alertViewController, animated: true, completion: nil)
        
    }
    
    /// Displaying PopUp for showing the Error Message
    /// - Parameters:
    ///   - message: Error Message
    ///   - controller: In Which Controller Displaying
    @objc func displayErrorMessage(message: String, controller: UIViewController) {
        
        controller.view.endEditing(true)
        
        // create a new style
        var style = ToastStyle()

        // this is just one of many style options
        style.messageColor = .white

        // present the toast with the new style
        controller.view.makeToast(message, duration: 3.0, position: .top, style: style)

        // or perhaps you want to use this style for all toasts going forward?
        // just set the shared style and there's no need to provide the style again
        ToastManager.shared.style = style

        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true

        // toggle queueing behavior
        ToastManager.shared.isQueueEnabled = true
        
    }
    
    
    @objc func shareToOthersThroughSocials(shareMessage: String, controller: UIViewController) {
        
        // text to share
        let text = shareMessage

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        controller.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func alertWithTextField(title: String, message: String = "", controller: UIViewController, completionHandler: @escaping (_ data: Any) -> Void) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        ac.addAction(cancelAction)
        
        ac.addTextField { (textField) in
            textField.placeholder = "Enter Comment"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let textField = ac.textFields![0]
            textField.placeholder = "Enter Comment"
            // do something interesting with "answer" here
            
            DispatchQueue.main.async {
                completionHandler(textField.text!)
            }
            
        }

        ac.addAction(submitAction)

        controller.present(ac, animated: true)
    }
    
    func webViewPrinFormatter(webviewPrint: UIViewPrintFormatter) {
        
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "page"
        printInfo.outputType = .general
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = false
        printController.printFormatter = webviewPrint
        printController.present(animated: true, completionHandler: nil)
        
    }
    
    func drawRouteFromSelectedLocationToDestinationLocation(title : String, currentLocationLat: Double, currentLocationLng: Double, destinationLat : Double, destinationLng : Double, viewController: UIViewController) {

        let lat = destinationLat //.trimmingCharacters(in: .whitespacesAndNewlines)
        let lng = destinationLng //.trimmingCharacters(in: .whitespacesAndNewlines)

        print(lat)
        print(lng)

        if lat == 0.0 || lng == 0.0 {
            displayErrorMessage(message: "Direction is not availble for this location", controller: viewController)
            return
        }

        
        var isGoogleMapsAvailable = false
        var isAppleMapsAvailable = false
        
        // For Google Maps
        if UIApplication.shared.canOpenURL(NSURL(string: "comgooglemaps://")! as URL) {
            isGoogleMapsAvailable = true
        }
        if UIApplication.shared.canOpenURL(NSURL(string: "http://maps.apple.com/")! as URL) {
            
            isAppleMapsAvailable = true
        }
        
        if isGoogleMapsAvailable == true && isAppleMapsAvailable == true {
            presenActionSheet(currentLocationLat: currentLocationLat, currentLocationLng: currentLocationLng, destinationLat: destinationLat, destinationLng: destinationLng, viewController: viewController)
        }
        else {
            
            // For Google Maps
            if UIApplication.shared.canOpenURL(NSURL(string: "comgooglemaps://")! as URL) {
                
                let url : String = String(format: "comgooglemaps://?saddr=%f,%f&daddr=%f,%f&directionsmode=driving",currentLocationLat,currentLocationLng,lat,lng).replacingOccurrences(of: " ", with: "%20")
                UIApplication.shared.open(NSURL(string: url)! as URL, options: [:], completionHandler: nil)
//                "comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving")!)

            }
            else if UIApplication.shared.canOpenURL(NSURL(string: "http://maps.apple.com/")! as URL) {
                                
                let url : String = String(format: "http://maps.apple.com/maps?daddr=%f,%f&saddr=%f,%f", currentLocationLat,currentLocationLng,lat,lng).replacingOccurrences(of: " ", with: "%20")
                UIApplication.shared.open(NSURL(string: url)! as URL, options: [:], completionHandler: nil)
            }
            
        }
        
    }
    
    func presenActionSheet(currentLocationLat: Double, currentLocationLng: Double, destinationLat : Double, destinationLng : Double, viewController: UIViewController) {
        
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please choose", message: "", preferredStyle: .actionSheet)

        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)

        let appleMapsAction = UIAlertAction(title: "Apple Maps", style: .default) { _ in
            
            let url : String = String(format: "http://maps.apple.com/maps?daddr=%f,%f&saddr=%f,%f", currentLocationLat,currentLocationLng,destinationLat,destinationLng).replacingOccurrences(of: " ", with: "%20")
            UIApplication.shared.open(NSURL(string: url)! as URL, options: [:], completionHandler: nil)
            
        }
        actionSheetControllerIOS8.addAction(appleMapsAction)

        let googleMapsButton = UIAlertAction(title: "Google Maps", style: .default) { _ in
                print("Google Maps")
            
            let url : String = String(format: "comgooglemaps://?saddr=%f,%f&daddr=%f,%f&directionsmode=driving",currentLocationLat,currentLocationLng,destinationLat,destinationLng).replacingOccurrences(of: " ", with: "%20")
            UIApplication.shared.open(NSURL(string: url)! as URL, options: [:], completionHandler: nil)
            
        }
        actionSheetControllerIOS8.addAction(googleMapsButton)
        viewController.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
    }
    
}
