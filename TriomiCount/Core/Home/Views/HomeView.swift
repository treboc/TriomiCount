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
          Label("New Session", systemSymbol: .house)
        }

      PlayerListView()
        .tabItem {
          Label("Players", systemSymbol: .person3Fill)
        }

      SessionsListView()
        .tabItem {
          Label("Sessions", systemSymbol: .listBulletRectangle)
        }

      SettingsView()
        .tabItem {
          Label("Settings", systemSymbol: .wrenchAndScrewdriverFill)
        }
    }
  }

  init() {
    UITabBar.appearance().tintColor = UIColor(.primaryAccentColor)
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
