//
//  TopView.swift
//  Melu
//
//  Created by Madhusudhan Reddy Putta on 21/06/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import UIKit

protocol TopViewDelegate {
    func backTapped()
    func searchTapped()
    func notificationTapped()
    func moreNotificationTapped()
    func serviceRequestTapped()
    
}

class TopView: UIView {
    
    var topViewDelegate : TopViewDelegate!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var titleLblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBtnTrailingConstraint: NSLayoutConstraint!

    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var notificationCountLbl: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension TopView {
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        topViewDelegate.backTapped()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        topViewDelegate.searchTapped()
    }
    
    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "more") {
            topViewDelegate.moreNotificationTapped()
        }
        else {
            topViewDelegate.notificationTapped()
        }        
    }
    
    @IBAction func serviceRequestButtonTapped(_ sender: UIButton) {
        topViewDelegate.serviceRequestTapped()
    }
    
}

