//
//  MainMenuView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import Inject
import Introspect
import SwiftUI
import PageSheet
import SFSafeSymbols

struct HomeView: View {
  var body: some View {
    TabView {
      SessionOnboardingView()
        .tabItem {
          Label(L10n.HomeView.newSession, systemSymbol: .house)
        }

      PlayerListView()
        .tabItem {
          Label(L10n.HomeView.players, systemSymbol: .person3Fill)
        }

      SessionsListView()
        .tabItem {
          Label(L10n.HomeView.sessions, systemSymbol: .listBulletRectangle)
        }

      SettingsView()
        .tabItem {
          Label(L10n.SettingsView.settings, systemSymbol: .wrenchAndScrewdriverFill)
        }
    }
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HomeView()
        .previewDevice("iPhone 12")
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.portrait)
    }
  }
}
