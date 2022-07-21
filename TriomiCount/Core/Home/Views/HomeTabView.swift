//
//  MainMenuView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import SFSafeSymbols

struct HomeTabView: View {
  var body: some View {
    TabView {
      SessionOnboardingView()
        .tabItem {
          Label(L10n.newSession, systemSymbol: .house)
        }

      PlayerListView()
        .tabItem {
          Label(L10n.players, systemSymbol: .person3Fill)
        }

      SessionsListView()
        .tabItem {
          Label(L10n.sessions, systemSymbol: .listBulletRectangle)
        }

      SettingsView()
        .tabItem {
          Label(L10n.settings, systemSymbol: .wrenchAndScrewdriverFill)
        }
    }
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HomeTabView()
        .previewDevice("iPhone 12")
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.portrait)
    }
  }
}
