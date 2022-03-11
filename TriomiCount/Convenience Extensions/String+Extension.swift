//
//  String+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 06.02.22.
//

import Foundation

extension String {
    func getInitials() -> String {
        var initials: String = ""
        
        for char in self {
            if char.isLetter && initials.count < 2 {
                initials.append(contentsOf: char.uppercased())
            }
        }
        
        return initials
    }
    
    func isValidName() -> Bool {
        if !self.isEmpty && self.count < 15 {
            return true
        }
        return false
    }
}
