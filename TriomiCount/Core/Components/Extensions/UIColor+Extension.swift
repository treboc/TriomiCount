//
//  UIColor+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.05.22.
//

import UIKit

extension UIColor {
  // credit: @beyowulf
  // https://stackoverflow.com/questions/47365583/determining-text-color-from-the-background-color-in-swift/47366748
  var isDarkColor: Bool {
    var r, g, b, a: CGFloat
    (r, g, b, a) = (0, 0, 0, 0)
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
    return  lum < 0.50
  }

  class func color(withData data: Data) -> UIColor? {
    return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) // as UIColor?
  }

  func encode() -> Data? {
    return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
  }
}

extension UIColor {
  public convenience init?(hex: String) {
    let r, g, b, a: CGFloat

    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])

      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          a = CGFloat(hexNumber & 0x000000ff) / 255

          self.init(red: r, green: g, blue: b, alpha: a)
          return
        }
      }
    }

    return nil
  }
}

extension UIColor {
  struct FavoriteColor {
    let name: String
    let color: UIColor
  }

  struct FavoriteColors {
    static let colors: [FavoriteColor] = [
      FavoriteColor(name: "Winter Sky", color: UIColor(red: 1.00, green: 0.13, blue: 0.43, alpha: 1.00)),
      FavoriteColor(name: "Lemon Glacier", color: UIColor(red: 0.98, green: 1.00, blue: 0.07, alpha: 1.00)),
      FavoriteColor(name: "Maximum Blue Purple", color: UIColor(red: 0.67, green: 0.60, blue: 1.00, alpha: 1.00))
    ]
  }
}

// Extension for lighter and darker UIColors, by https://github.com/rwbutler
extension UIColor {
  public enum Lightness {
    private static let lightScalingFactor: Double       = 1.25
    private static let lighterScalingFactor: Double     = 1.5
    private static let lightestScalingFactor: Double    = 1.75
    private static let whiteScalingFactor: Double       = Double.greatestFiniteMagnitude

    case lightness(scalingFactor: Double)
    case light
    case lighter
    case lightest
    case white

    fileprivate var scale: Double {
      switch self {
      case .lightness(let scalingFactor):
        return scalingFactor
      case .light:
        return Lightness.lightScalingFactor
      case .lighter:
        return Lightness.lighterScalingFactor
      case .lightest:
        return Lightness.lightestScalingFactor
      case .white:
        return Lightness.whiteScalingFactor
      }
    }
  }

  public enum Darkness {

    private static let darkScalingFactor: Double    = 0.75
    private static let darkerScalingFactor: Double  = 0.5
    private static let darkestScalingFactor: Double = 0.25
    private static let blackScalingFactor: Double   = 0.0

    case darkness(Double)
    case dark
    case darker
    case darkest
    case black

    fileprivate var scale: Double {
      switch self {
      case .darkness(let scalingFactor):
        return scalingFactor
      case .dark:
        return Darkness.darkScalingFactor
      case .darker:
        return Darkness.darkerScalingFactor
      case .darkest:
        return Darkness.darkestScalingFactor
      case .black:
        return Darkness.blackScalingFactor
      }
    }
  }

  private func darker(darkness: Double) -> UIColor {
    guard darkness <= 1.0 else { return self }

    let scalingFactor: CGFloat = CGFloat(darkness)
    var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    let newR = CGFloat.maximum(r * scalingFactor, 0.0),
        newG = CGFloat.maximum(g * scalingFactor, 0.0),
        newB = CGFloat.maximum(b * scalingFactor, 0.0)
    return UIColor(red: newR, green: newG, blue: newB, alpha: 1.0)
  }

  private func lighter(lightness: Double) -> UIColor {
    guard lightness >= 1.0 else { return self }

    let scalingFactor: CGFloat = CGFloat(lightness)
    var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    let newR = CGFloat.minimum(r * scalingFactor, 1.0),
        newG = CGFloat.minimum(g * scalingFactor, 1.0),
        newB = CGFloat.minimum(b * scalingFactor, 1.0)
    return UIColor(red: newR, green: newG, blue: newB, alpha: 1.0)
  }

  public func shade(_ lightness: Lightness) -> UIColor {
    switch lightness {
    case .white:
      return UIColor.white
    default:
      return self.lighter(lightness: lightness.scale)
    }
  }

  public func shade(_ darkness: Darkness) -> UIColor {
    return self.darker(darkness: darkness.scale)
  }
}
