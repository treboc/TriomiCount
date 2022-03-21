//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct SettingsView: View {
  @Binding var selectedAppearance: Int
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.dismiss) var dismiss

  var body: some View {
    NavigationView {
      Form {
        Section("Theme") {
          colorSchemePicker
        }

        Section("Rules") {
          VStack(alignment: .leading) {
            Text("Beginning").font(.headline)
              .padding(.bottom, 10)
            Text("rules.beginning.first")
          }
        }
      }
      .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
      .navigationTitle("settingsView.settings")
    }
  }
}

extension SettingsView {
  private var colorSchemePicker: some View {
    Picker("Color Scheme", selection: $selectedAppearance) {
      HStack {
        Text("settingsView.colorScheme.system")
        Spacer()
        if selectedAppearance == 0 {
          Image(systemName: "checkmark")
        }
      }
      .contentShape(Rectangle())
      .onTapGesture { selectedAppearance = 0 }

      HStack {
        Text("settingsView.colorScheme.light")
        Spacer()
        if selectedAppearance == 1 {
          Image(systemName: "checkmark")
        }
      }
      .contentShape(Rectangle())
      .onTapGesture { selectedAppearance = 1 }

      HStack {
        Text("settingsView.colorScheme.dark")
        Spacer()
        if selectedAppearance == 2 {
          Image(systemName: "checkmark")
        }
      }
      .contentShape(Rectangle())
      .onTapGesture { selectedAppearance = 2 }
    }
    .pickerStyle(.automatic)
  }
}
