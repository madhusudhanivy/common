//
//  UITextField+View.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 20/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    enum Direction {
            case Left
            case Right
        }
        
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor, isNeedCornerRadius: Bool, imageColor: UIColor = .appColor ){
            let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            mainView.isUserInteractionEnabled = false
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            view.backgroundColor = UIColor.clear
            view.clipsToBounds = true
            mainView.addSubview(view)
            
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 14.0, y: (view.frame.size.height/2) - 5, width: 10.0, height: 10.0)
            imageView.backgroundColor = UIColor.clear
            imageView.setImageColor(color: .appColor)
            view.addSubview(imageView)
                        
            let seperatorView = UIView()
            seperatorView.backgroundColor = UIColor.clear
            mainView.addSubview(seperatorView)
            
            if(Direction.Left == direction){ // image left
                seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
                self.leftViewMode = .always
                self.leftView = mainView
            } else { // image right
                seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
                self.rightViewMode = .always
                self.rightView = mainView
            }
            
            seperatorView.backgroundColor = UIColor.clear
            
            if isNeedCornerRadius == true {
                applyCornerRadius(self)
            }
        }
    
}
