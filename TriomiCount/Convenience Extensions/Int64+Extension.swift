//
//  Double+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 01.03.22.
//
// by: https://stackoverflow.com/questions/36376897/swift-2-0-format-1000s-into-a-friendly-ks

import Foundation

// Thanks to https://stackoverflow.com/a/45508260/8366079
extension Int64 {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
