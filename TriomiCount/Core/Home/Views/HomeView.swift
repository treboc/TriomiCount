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
  @State private var isAnimating: Bool = false
  let animationDelay = 0.25

  @State private var settingsViewIsShown: Bool = false
  @EnvironmentObject var appState: AppState
  private var lastSession: Session? {
    if let lastSession = Session.getLastNotFinishedSession(context: PersistentStore.shared.context) {
      return lastSession
    } else {
      return nil
    }
  }

  var body: some View {
    NavigationView {
      ZStack {
        Color.primaryBackground
          .ignoresSafeArea()

        VStack(spacing: 100) {
          Logo()

          if isAnimating {
            VStack(spacing: 15) {
              if let lastSession = lastSession {
                NavigationLink(L10n.HomeView.resume) {
                  SessionMainView(viewModel: SessionViewModel(lastSession: lastSession))
                }
              }

              NavigationLink(L10n.HomeView.newSession) {
                SessionOnboardingView()
                  .id(appState.onboardingScreen)
              }

              NavigationLink(L10n.HomeView.players, destination: PlayerListView.init)

              NavigationLink(L10n.HomeView.sessions, destination: SessionsListView.init)
            }
            .buttonStyle(.offsetStyle)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 50)
            .padding(.bottom, 20)
          }

        }
        .padding(.vertical)
        .navigationBarHidden(true)
        .tint(Color.primaryAccentColor)
        .onAppear {
          isAnimating = true
        }
      }
      .overlay(settingsButton, alignment: .topTrailing)
    }

    .pageSheet(isPresented: $settingsViewIsShown) {
      SettingsView()
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
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
      Button("\(Image(systemSymbol: .wrenchAndScrewdriverFill))") {
        settingsViewIsShown.toggle()
      }
      .buttonStyle(.circularOffsetStyle)
      .padding([.top, .trailing])
  }
}
