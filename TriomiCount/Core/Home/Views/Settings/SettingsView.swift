//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI
import Introspect

struct SettingsView: View {
  @AppStorage(SettingsKeys.idleDimmingDisabled) var idleDimmingDisabled: Bool = true
  @State private var showRules: [Bool] = Array(repeating: false, count: 4)

  var body: some View {
    NavigationView {
      ZStack {
        LinearGradient(colors: [.primaryBackground.opacity(0.8), .primaryBackground.opacity(0.2)],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()

        Form {
          Section(L10n.SettingsView.ColorScheme.title) {
            ColorSchemePicker()
          }

          Section {
            Toggle(L10n.SettingsView.IdleDimmingDisabled.pickerLabelText, isOn: $idleDimmingDisabled)
              .tint(.accentColor)
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
      }
      .navigationTitle(L10n.settings)
      .roundedNavigationTitle()
    }
    // Set the forms background
    .introspectTableView {
      $0.backgroundColor = .clear
    }
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
    AboutView()
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
      Picker("Choose Appearance", selection: $appearanceManager.appearance) {
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
      .pickerStyle(.inline)
      .labelsHidden()
    }
  }
}
