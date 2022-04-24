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
        Section("Color Theme") {
          ColorSchemePicker(selectedAppearance: $selectedAppearance)
        }

        Section(L10n.Rules.title) {
            rulesSection
        }
      }
      .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
      .navigationTitle(L10n.Rules.title)
    }
  }
}

extension SettingsView {
  private var rulesSection: some View {
    List {
      RulesSection(sectionHeader: L10n.Rules.Setup.header, sectionBody: L10n.Rules.Setup.body)
      RulesSection(sectionHeader: L10n.Rules.LetsGo.header, sectionBody: L10n.Rules.LetsGo.body)
      RulesSection(sectionHeader: L10n.Rules.EndOfGame.header, sectionBody: L10n.Rules.EndOfGame.body)
      RulesSection(sectionHeader: L10n.Rules.BonusPoints.header, sectionBody: L10n.Rules.BonusPoints.body)
    }
    .navigationTitle(Rules.rulesTitle)
  }
}

extension SettingsView {
  struct ColorSchemePicker: View {
    @Binding var selectedAppearance: Int
    var pickerTitle: String {
      switch selectedAppearance {
      case 0:
        return "System"
      case 1:
        return "Light"
      case 2:
        return "Dark"
      default:
        return "Unknown"
      }
    }

    var body: some View {
      Picker(pickerTitle, selection: $selectedAppearance) {
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
}

struct RulesSection: View {
  @State private var detailIsShown: Bool = false
  let sectionHeader: String
  let sectionBody: String

  var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: 20) {
        HStack(alignment: .center) {
          Text(sectionHeader)
            .font(detailIsShown ? .headline : nil)
          Spacer()
          Image(systemSymbol: .chevronRight)
            .font(.caption)
            .foregroundColor(.gray)
            .rotationEffect(Angle(degrees: detailIsShown ? 90 : 0))
        }
        .padding(.vertical, 8)
        .animation(.none, value: detailIsShown)
        if detailIsShown {
          Text(sectionBody)
            .animation(.default, value: detailIsShown)
        }
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      detailIsShown.toggle()
    }
  }
}
