//
//  NSObject+Foundation.swift
//  SportsFight
//
//  Created by Madhusudhan on 30/07/18.
//  Copyright © 2018 Digital Minds Solutions. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    static func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X (XXX) XXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func priceUSAFormat() -> String {
        
        if let myInteger = Float(self) {
            let myNumber = NSNumber(value: myInteger)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
            return formatter.string(from: myNumber)!
        }
        
        return "$0.00"
    }
    
    static func checkNSNumberNull(_ inputValue: Any) -> String {
                
        var valueString = inputValue
        
        if (valueString as AnyObject).isEqual(NSNull()) {
            valueString = ""
        }
        else {
            valueString = String(valueString as! Int)
            
        }
        
        return valueString as! String
    }
    
    static func checkDateNull(_ dateValue: Any) -> String {
        var newDateValue: Any = dateValue
        if  (newDateValue as AnyObject).isEqual(NSNull()) {
            newDateValue = ""
        }
        else {
                        
            let actualDateString = (newDateValue as! String).replacingOccurrences(of: "+00:00", with: "")
            
            // create dateFormatter with UTC time format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz"
            var date = dateFormatter.date(from: actualDateString)
            
            // if .zzz format not coming from date format // then give only upto seconds format
            if date == nil {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                date = dateFormatter.date(from: actualDateString)
            }
            
            // if .ss format not coming from date format // then give only upto milli seconds format
            if date == nil {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                date = dateFormatter.date(from: actualDateString)
            }
            
            // change to a readable time format and change to local time zone
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateFormatter.timeZone = NSTimeZone.local
            let timeStamp = dateFormatter.string(from: date!)
            
            return timeStamp
            
        }
        return newDateValue as! String
    }
    
    static func checkDateWithTimeNull(_ dateValue: Any) -> String {
        var newDateValue: Any = dateValue
        if  (newDateValue as AnyObject).isEqual(NSNull()) {
            newDateValue = ""
        }
        else {
            
            let actualDateString = (newDateValue as! String).replacingOccurrences(of: "+00:00", with: "")
            
            // create dateFormatter with UTC time format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz"
            var date = dateFormatter.date(from: actualDateString)
            
            if date == nil {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                date = dateFormatter.date(from: actualDateString)
            }
            
            if date == nil {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                date = dateFormatter.date(from: actualDateString)
            }
            
            // change to a readable time format and change to local time zone
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
            dateFormatter.timeZone = NSTimeZone.local
            let timeStamp = dateFormatter.string(from: date!)
            
            return timeStamp
            
        }
        return newDateValue as! String
    }
    
    
    static func checkBoolNull(_ value : Any) -> Bool {
        
        var newBoolValue : Any = value
        
        if (newBoolValue as AnyObject).isEqual(NSNull()) {
            newBoolValue = false
        }
        else
        {
//            print(newBoolValue)
        }
        return newBoolValue as! Bool
    }
    
    static func checkArray(_ value : Any) -> NSArray {
        
        var newValue : Any = value
        
        if (newValue as AnyObject).isEqual(NSNull()) {
            newValue = NSArray()
        }
        
        return newValue as! NSArray
    }
    
    static func checkDictionary(_ value : Any) -> NSDictionary {
        
        var newValue : Any = value
        
        if (newValue as AnyObject).isEqual(NSNull()) {
            newValue = NSDictionary()
        }
        
        return newValue as! NSDictionary
    }
    
    static func checkNumberNullWithVotesText(_ inputValue: Any) -> String {
        
        var valueString : Any = inputValue
        
        if (valueString as AnyObject).isEqual(NSNull()) {
            valueString = ""
        }
        else {
            valueString = String(format: "%d", valueString as! Int)
        }
        
        var actualValue = valueString as! String
        
        if Int(actualValue) == 0 || Int(actualValue) == 1 {
            
            actualValue = String(format: "%@ Vote", actualValue)
        }
        else {
            actualValue = String(format: "%@ Votes", actualValue)
        }
        
        return actualValue
    }
    
}


extension String {
    
    func shortcutLettersFromName() -> String {
        
        let array = self.components(separatedBy: " ")
        
        var shortCutLetters = ""
        
        if array.count >= 2 {
            shortCutLetters = String(array[0].prefix(1)) + String(array[1].prefix(1))
        }
        else {
            shortCutLetters = String(array[0].prefix(1)) + String(array[0].prefix(1))
        }
        
        return shortCutLetters.uppercased()
        
    }
    
    func monthDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let convertedDate = dateFormatter.date(from: self)
        
        if convertedDate == nil {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let convertedDate = dateFormatter.date(from: self)
            return convertedDate!
            
        }
        
        return convertedDate!
    }
    
//    func convertStringToDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") ->
    
    func getStatusColor() -> String {
        
        if self == "Yet to Start" || self == "0" {
            return "3E6579"
        }
        else if self == "In Transit" || self == "5" {
            return "1abc9c"
        }
        else if self == "Break Down" || self == "15" {
            return "f1ca0f"
        }
        else if self == "Completed" || self == "10" {
            return "95A5A6"
        }
        else if self == "Cancelled" || self == "20" {
            return "e74c3c"
        }
        else {
            return "1E3340"
        }
    }
    
    func getStatusImageName() -> String {
        if self == "Open" || self == "0" {
            return "open-dark-32"
        }
        else if self == "Approved" || self == "5" {
            return "approved-dark-32"
        }
        else if self == "Declined" || self == "10" {
            return "cancel-dark-32"
        }
        else if self == "Closed" || self == "15" {
            return "closed-dark-32"
        }
        
        return "open-dark-32"
    }
    
}
