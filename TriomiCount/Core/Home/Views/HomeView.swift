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
          VStack(spacing: 15) {
            if lastSession != nil {
              lastSessionButton
            }

            PushStyledNavigationLink(title: L10n.HomeView.newSession) { SessionOnboardingView()
                .id(appState.onboardingScreen)
            }
            .offset(y: isAnimating ? 0 : 800)
            .animation(.easeInOut(duration: 0.4).delay(lastSession != nil ? animationDelay : 0), value: isAnimating)
            PushStyledNavigationLink(title: L10n.HomeView.players) { PlayerListView() }
              .offset(y: isAnimating ? 0 : 800)
              .animation(.easeInOut(duration: 0.4).delay(lastSession != nil ? animationDelay * 2 : animationDelay), value: isAnimating)
            PushStyledNavigationLink(title: L10n.HomeView.sessions) { SessionsListView() }
              .offset(y: isAnimating ? 0 : 800)
              .animation(.easeInOut(duration: 0.4).delay(lastSession != nil ? animationDelay * 3 : animationDelay * 2), value: isAnimating)
          }
          .frame(maxWidth: .infinity)
          .padding(.horizontal, 50)
          .padding(.bottom, 20)
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
        .sheetPreference(.grabberVisible(true))
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

  @ViewBuilder
  private var lastSessionButton: some View {
    if let lastSession = lastSession {
      PushStyledNavigationLink(title: L10n.HomeView.resume) {
        SessionMainView(viewModel: SessionViewModel(lastSession: lastSession))
      }
      .offset(y: isAnimating ? 0 : 800)
      .animation(.easeInOut(duration: 0.4), value: isAnimating)
    }
  }
}
