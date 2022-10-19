//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage(Constants.AppStorageKeys.idleDimmingDisabled) private var idleDimmingDisabled: Bool = true
  @AppStorage(Constants.AppStorageKeys.hapticsEnabled) private var hapticsEnabled: Bool = true

  var body: some View {
    NavigationView {
      Form {
        Section {
          AppearancePicker()
          Toggle(L10n.SettingsView.HapticsEnabled.toggleLabelText, isOn: $hapticsEnabled)
          Toggle(L10n.SettingsView.IdleDimmingDisabled.toggleLabelText, isOn: $idleDimmingDisabled)
        } header: {
          Text(L10n.SettingsView.IdleDimmingDisabled.options)
        } footer: {
          Text(L10n.SettingsView.IdleDimmingDisabled.importantMessage)
            .font(.caption)
        }

        Section(L10n.Rules.title, content: RulesSection.init)

        Section {
          NavigationLink("About", destination: AboutView.init)
          reviewLink
          NavigationLink(L10n.LegalNoticeView.title, destination: LegalNoticeView.init)
        }
      }
      .scrollContentBackground(.hidden)
      .background(Background())
      .navigationTitle(L10n.SettingsView.title)
      .roundedNavigationTitle()
      .tint(.accentColor)
    }
  }
}

extension SettingsView {
  private var reviewLink: some View {
    Link(destination: Constants.reviewURL) {
      HStack {
        Text("Rate This App ❤️")
        Spacer()
        Image(systemName: "arrow.up.right")
      }
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
