//
//  MainMenuView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import PageSheet
import SFSafeSymbols

struct HomeView: View {
  @EnvironmentObject var appState: AppState

  @State private var showSettingsView: Bool = false
//  @AppStorage("isDarkMode") private var isDarkMode: Bool = true
  @AppStorage("selectedAppearance") private var selectedAppearance = 0

  @State private var logoIsAnimated: Bool = true
  @State private var lastSession: Game?

  var body: some View {
    NavigationView {
      ZStack {
        // Background Layer
        Color.primaryBackground
          .ignoresSafeArea()
        
        // Foreground Layer
        VStack {
          settingsButton

          VStack(spacing: 20) {
            
            Spacer()
            
            Logo()
              .offset(y: -40)
            
            Spacer(minLength: 20)

            VStack(spacing: 15) {
              if lastSession != nil {
                PrimaryNavigationLink(destinationView: GameView(vm: GameViewModel(lastGame: lastSession!)), labelTextStringKey: "navigation_link.resume")
              }
              PrimaryNavigationLink(destinationView: GameOnboardingView().id(appState.onboardingScreen), labelTextStringKey: "navigation_link.new_game")
              PrimaryNavigationLink(destinationView: PlayerListView(), labelTextStringKey: "navigation_link.players")
              PrimaryNavigationLink(destinationView: GamesListView(), labelTextStringKey: "navigation_link.games")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 50)
            .padding(.bottom, 20)

            Spacer()
          }
          .navigationBarHidden(true)
          .tint(Color.primaryAccentColor)
        }
        .onAppear {
          lastSession = Game.getLastNotFinishedSession(context: PersistentStore.shared.context)
        }
      }
    }
    .pageSheet(isPresented: $showSettingsView) {
//      SettingsView(isDarkMode: $isDarkMode)
      SettingsView(selectedAppearance: $selectedAppearance)
        .sheetPreference(.grabberVisible(true))
        .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
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


// MARK: - Components
extension HomeView {
  var settingsButton: some View {
    HStack {
      Spacer()

      Button("\(Image(systemSymbol: .wrenchAndScrewdriverFill))") {
        showSettingsView.toggle()
      }
      .buttonStyle(.circularOffsetStyle)
    }
    .padding()
  }
}
