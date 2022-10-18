//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

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
            AppearancePicker()
          }

          Section {
            Toggle(L10n.SettingsView.IdleDimmingDisabled.pickerLabelText, isOn: $idleDimmingDisabled)
          } header: {
            Text(L10n.SettingsView.IdleDimmingDisabled.options)
          } footer: {
            Text(L10n.SettingsView.IdleDimmingDisabled.importantMessage)
              .font(.caption)
          }
          .tint(.primaryAccentColor)

          Section(L10n.Rules.title) {
            rulesSection
          }

          Section(footer: footer, content: { EmptyView() })
        }
      }
      .scrollContentBackground(.hidden)
      .background(Background())
      .navigationTitle(L10n.SettingsView.title)
      .roundedNavigationTitle()
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
  }
}
