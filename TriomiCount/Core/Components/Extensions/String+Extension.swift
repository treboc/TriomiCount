//
//  String+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 06.02.22.
//

import Foundation

extension String {
  var initials: String {
    var initials: String = ""
    for char in self {
      if char.isLetter && initials.count < 2 {
        initials.append(contentsOf: char.uppercased())
      }
    }
    return initials
  }

  var isValidName: Bool {
    !self.isEmpty && self.count < 21
  }

  var isInt: Bool {
    return Int(self) != nil
  }
}
