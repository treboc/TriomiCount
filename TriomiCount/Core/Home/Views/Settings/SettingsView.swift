//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct SettingsView: View {
  @Environment(\.dismiss) var dismiss
  @AppStorage(SettingsKeys.idleDimmingDisabled) var idleDimmingDisabled: Bool = true
  @State private var showRules: [Bool] = Array(repeating: false, count: 4)

  var body: some View {
    NavigationView {
      Form {
        Section(L10n.SettingsView.ColorScheme.title) {
          ColorSchemePicker()
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

        Section(footer: footer, content: { EmptyView() })
      }
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(L10n.cancel) {
            dismiss()
          }
        }
      })
      .navigationTitle(L10n.SettingsView.settings)
    }
    // accentColor will be deprecated, but .tint() will not work here!
    .accentColor(.primaryAccentColor)
  }
}

extension SettingsView {
  private var rulesSection: some View {
    Group {
      DisclosureGroup(L10n.Rules.Setup.header, isExpanded: $showRules[0]) {
        Text(L10n.Rules.Setup.body)
      }
      DisclosureGroup(L10n.Rules.LetsGo.header, isExpanded: $showRules[1]) {
        Text(L10n.Rules.LetsGo.body)
      }
      DisclosureGroup(L10n.Rules.EndOfGame.header, isExpanded: $showRules[2]) {
        Text(L10n.Rules.EndOfGame.body)
      }
      DisclosureGroup(L10n.Rules.BonusPoints.header, isExpanded: $showRules[3]) {
        Text(L10n.Rules.BonusPoints.body)
      }
    }
  }

  private var footer: some View {
    VStack(spacing: 10) {
      Text("Made with ☕️ and 💚 by")
        .font(.headline)
      Text("Marvin Lee")
        .font(.subheadline.bold())
      Text("Version 1.0.0")

      AboutView()

    }
    .frame(maxWidth: .infinity, alignment: .center)
  }
}

extension SettingsView {
  struct ColorSchemePicker: View {
    @EnvironmentObject var appearanceManager: AppearanceManager

    var pickerTitle: String {
      switch appearanceManager.appearance {
      case .dark:
        return L10n.SettingsView.ColorScheme.dark
      case .light:
        return L10n.SettingsView.ColorScheme.light
      case .system:
        return L10n.SettingsView.ColorScheme.system
      }
    }

    var body: some View {
      Picker(pickerTitle, selection: $appearanceManager.appearance) {
        HStack {
          Text(L10n.SettingsView.ColorScheme.system)
          Spacer()
          if appearanceManager.appearance == .system {
            Image(systemName: "checkmark")
          }
        }
        .contentShape(Rectangle())
        .onTapGesture { appearanceManager.appearance = .system }

        HStack {
          Text(L10n.SettingsView.ColorScheme.light)
          Spacer()
          if appearanceManager.appearance == .light {
            Image(systemName: "checkmark")
          }
        }
        .contentShape(Rectangle())
        .onTapGesture { appearanceManager.appearance = .light }

        HStack {
          Text(L10n.SettingsView.ColorScheme.dark)
          Spacer()
          if appearanceManager.appearance == .dark {
            Image(systemName: "checkmark")
          }
        }
        .contentShape(Rectangle())
        .onTapGesture { appearanceManager.appearance = .dark }
      }
      .pickerStyle(.automatic)
    }
  }
}
