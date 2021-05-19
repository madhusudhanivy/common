//
//  DeviceInfo.swift
//  common
//
//  Created by Madhusudhan Reddy Putta on 19/05/21.
//

import Foundation

public final class DeviceInfo {

    public static let shared = DeviceInfo()
    
    public var deviceToken = ""
    public var deviceName = UIDevice.current.systemName
    public var isUserLogined = false
    public var SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    public var deviceGuid = ""
        
}
