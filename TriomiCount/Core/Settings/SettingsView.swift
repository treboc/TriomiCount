//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage(SettingsKeys.idleDimmingDisabled) var idleDimmingDisabled: Bool = true

  var body: some View {
    NavigationView {
      Form {
        Section {
          AppearancePicker()
          Toggle(L10n.SettingsView.IdleDimmingDisabled.pickerLabelText, isOn: $idleDimmingDisabled)
        } header: {
          Text(L10n.SettingsView.IdleDimmingDisabled.options)
        } footer: {
          Text(L10n.SettingsView.IdleDimmingDisabled.importantMessage)
            .font(.caption)
        }

        Section(L10n.Rules.title, content: RulesSection.init)

        Section {
          NavigationLink("About", destination: AboutView.init)
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
  struct RulesSection: View {
    @State private var showRules: [Bool] = Array(repeating: false, count: 4)

    var body: some View {
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
      .animation(.none, value: showRules)
    }
  }
}
