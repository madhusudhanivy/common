//
//  ImagePicketManager.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 19/09/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerManagerDelegate {
    func customImagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    lazy var imagePickerController: UIImagePickerController = {
        
        /* Image Picker Controller */
        
        let imagePicker = UIImagePickerController()
        imagePicker.mediaTypes = [ "public.image"]
        
        return imagePicker
    }()
    
    var delegate: ImagePickerManagerDelegate!
    
    @objc class var shared : ImagePickerManager{
        
        struct singleton{
            static let instance = ImagePickerManager()
        }
        return singleton.instance
    }
    
    func chooseOptions(viewController: UIViewController) {
        
        // ImagePicker delegate
        imagePickerController.delegate = self
        
        let alert = UIAlertController(title: "", message: "Choose option", preferredStyle: .alert)
        alert.view.tintColor = UIColor.appColor
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_ ) in
            
        })
        alert.addAction(cancelAction)
        
        let recordAction = UIAlertAction(title: "Upload From Camera", style: .default, handler: { (_ ) in
            
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                AlertManager.shared.displayErrorMessage(message: "Device not supported camera", controller: viewController)
                return
            }
            
            self.imagePickerController.sourceType = .camera
            alert.dismiss(animated: true, completion: nil)
            viewController.present(self.imagePickerController, animated: true, completion: nil)
            
        })
        alert.addAction(recordAction)
        
        let galleryAction = UIAlertAction(title: "Upload From Gallery", style: .default, handler: { (_ ) in
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.mediaTypes = ["public.image"]
            alert.dismiss(animated: true, completion: nil)
            viewController.present(self.imagePickerController, animated: true, completion: nil)
            
        })
        alert.addAction(galleryAction)
        
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        self.profileButton.setBackgroundImage(info[.originalImage] as? UIImage, for: .normal)
        
        if delegate != nil {
            delegate.customImagePickerController(picker, didFinishPickingMediaWithInfo: info)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
