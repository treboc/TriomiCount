//
//  MainMenuView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import Inject
import SwiftUI
import PageSheet
import SFSafeSymbols

struct HomeView: View {
  @State private var showSettings: Bool = false
  @AppStorage("selectedAppearance") private var selectedAppearance = 0
  @EnvironmentObject var appState: AppState
  @State private var lastSession: Game?

  var body: some View {
    NavigationView {
      ZStack {
        Color.primaryBackground
          .ignoresSafeArea()

        VStack {
          settingsButton
          VStack(spacing: 20) {
            Spacer()
            Logo()
            Spacer(minLength: 20)
            VStack(spacing: 15) {
              if lastSession != nil {
                PushStyledNavigationLink(title: L10n.HomeView.resume) {
                  GameMainView(viewModel: GameViewModel(lastGame: lastSession!))
                }
              }
              PushStyledNavigationLink(title: L10n.HomeView.newGame) { GameOnboardingView()
                .id(appState.onboardingScreen) }
              PushStyledNavigationLink(title: L10n.HomeView.players) { PlayerListView() }
              PushStyledNavigationLink(title: L10n.HomeView.games) { GamesListView() }
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
    .pageSheet(isPresented: $showSettings) {
      SettingsView(selectedAppearance: $selectedAppearance)
        .sheetPreference(.grabberVisible(true))
        .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
    }
    .enableInjection()
  }

#if DEBUG
  @ObservedObject private var iO = Inject.observer
#endif
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
        showSettings.toggle()
      }
      .buttonStyle(.circularOffsetStyle)
    }
    .padding()
  }
}
