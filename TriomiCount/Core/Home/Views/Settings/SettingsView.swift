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
    List {
      RulesSection(sectionHeader: L10n.Rules.Setup.header, sectionBody: L10n.Rules.Setup.body)
      RulesSection(sectionHeader: L10n.Rules.LetsGo.header, sectionBody: L10n.Rules.LetsGo.body)
      RulesSection(sectionHeader: L10n.Rules.EndOfGame.header, sectionBody: L10n.Rules.EndOfGame.body)
      RulesSection(sectionHeader: L10n.Rules.BonusPoints.header, sectionBody: L10n.Rules.BonusPoints.body)
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
            .padding(.bottom, 10)
        }
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        detailIsShown.toggle()
      }
    }
  }
}
