//
//  Color.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.03.22.
//

import SwiftUI

extension Color {
  // --- Accent Colors
  public static var primaryAccentColor: Color {
    Color("PrimaryAccentColor")
  }

  public static var secondaryAccentColor: Color {
    Color("SecondaryAccentColor")
  }

  public static var tertiaryAccentColor: Color {
    Color("TertiaryAccentColor")
  }

  // --- Destructive Button Colors
  public static var destructiveButtonPrimaryColor: Color {
    Color("DestructiveButtonPrimaryColor")
  }

  public static var destructiveButtonSecondaryColor: Color {
    Color("DestructiveButtonSecondaryColor")
  }

  // --- Background Colors
  public static var primaryBackground: Color {
    Color("PrimaryBackground")
  }

  public static var secondaryBackground: Color {
    Color("SecondaryBackground")
  }

  public static var tertiaryBackground: Color {
    Color("TertiaryBackground")
  }

  public static var tertiaryBackgroundUIColor: UIColor {
    UIColor(named: "TertiaryBackground") ?? .clear
  }
}
