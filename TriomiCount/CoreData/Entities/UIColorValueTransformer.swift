//
//  UIColorValueTransformer.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.05.22.
//

import UIKit

// 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
@objc(UIColorValueTransformer)
final class ColorValueTransformer: NSSecureUnarchiveFromDataTransformer {

  /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
  static let name = NSValueTransformerName(rawValue: String(describing: ColorValueTransformer.self))

  // 2. Make sure `UIColor` is in the allowed class list.
  override static var allowedTopLevelClasses: [AnyClass] {
    return [UIColor.self]
  }

  /// Registers the transformer.
  public static func register() {
    let transformer = ColorValueTransformer()
    ValueTransformer.setValueTransformer(transformer, forName: name)
  }
}
