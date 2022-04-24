//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct SettingsView: View {
  @Binding var selectedAppearance: Int
  @Environment(\.dismiss) var dismiss
  @AppStorage(Settings.idleDimmingDisabled) var idleDimmingDisabled: Bool = true

  var body: some View {
    NavigationView {
      Form {
        Section(L10n.SettingsView.ColorScheme.title) {
          ColorSchemePicker(selectedAppearance: $selectedAppearance)
        }

        Section {
          Toggle(L10n.SettingsView.IdleDimmingDisabled.pickerLabelText, isOn: $idleDimmingDisabled)
        } header: {
          Text(L10n.SettingsView.IdleDimmingDisabled.options)
        } footer: {
          Text(L10n.SettingsView.IdleDimmingDisabled.importantMessage)
            .font(.caption)
        }

        Section(L10n.Rules.title) {
          rulesSection
        }
      }
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
        return L10n.SettingsView.ColorScheme.system
      case 1:
        return L10n.SettingsView.ColorScheme.light
      case 2:
        return L10n.SettingsView.ColorScheme.dark
      default:
        return "Unknown"
      }
    }

    var body: some View {
      Picker(pickerTitle, selection: $selectedAppearance) {
        HStack {
          Text(L10n.SettingsView.ColorScheme.system)
          Spacer()
          if selectedAppearance == 0 {
            Image(systemName: "checkmark")
          }
        }
        .contentShape(Rectangle())
        .onTapGesture { selectedAppearance = 0 }

        HStack {
          Text(L10n.SettingsView.ColorScheme.light)
          Spacer()
          if selectedAppearance == 1 {
            Image(systemName: "checkmark")
          }
        }
        .contentShape(Rectangle())
        .onTapGesture { selectedAppearance = 1 }

        HStack {
          Text(L10n.SettingsView.ColorScheme.dark)
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
