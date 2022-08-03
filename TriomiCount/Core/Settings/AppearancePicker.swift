//
//  AppearancePicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 21.07.22.
//

import Introspect
import SwiftUI

struct AppearancePicker: View {
  @EnvironmentObject var appearanceManager: AppearanceManager
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    Picker("Select Theme", selection: $appearanceManager.appearance) {
      ForEach(AppearanceManager.Appearance.allCases, id: \.self) {
        Text($0.title)
      }
    }
    .pickerStyle(.segmented)
    .introspectSegmentedControl { control in
      let textColor: UIColor = colorScheme == .dark ? .black : .white
      control.setTitleTextAttributes([.foregroundColor: textColor], for: .selected)
      control.selectedSegmentTintColor = UIColor(.accentColor)
    }
  }
}
