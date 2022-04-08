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

        NavigationLink(Rules.rulesTitle) {
          rulesSection
        }
      }
      .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
      .navigationTitle("settingsView.settings")
    }
  }
}

extension SettingsView {
  private var rulesSection: some View {
    List {
      RulesSection(sectionHeader: Rules.setupHeader, sectionBody: Rules.setupBody)
      RulesSection(sectionHeader: Rules.letsGoHeader, sectionBody: Rules.letsGoBody)
      RulesSection(sectionHeader: Rules.endOfGameHeader, sectionBody: Rules.endOfGameBody)
      RulesSection(sectionHeader: Rules.bonusPointsHeader, sectionBody: Rules.bonusPointsBody)
    }
    .navigationTitle(Rules.rulesTitle)
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

struct RulesSection: View {
  @State private var detailIsShown: Bool = false
  let sectionHeader: LocalizedStringKey
  let sectionBody: LocalizedStringKey

  var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: 20) {
        HStack(alignment: .center) {
          Text(sectionHeader)
            .font(.headline)
          Spacer()
          Image(systemSymbol: detailIsShown ? .chevronDown : .chevronRight)
            .font(.caption)
            .foregroundColor(.gray)
        }
        .onTapGesture {
          detailIsShown.toggle()
        }
        .animation(.none, value: detailIsShown)
        if detailIsShown {
          Text(sectionBody)
            .animation(.default, value: detailIsShown)
        }
      }
      .padding()
    }
  }

}
