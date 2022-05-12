//
//  Collection+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.05.22.
//

import Foundation

extension Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  /// https://stackoverflow.com/a/30593673/8366079
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
