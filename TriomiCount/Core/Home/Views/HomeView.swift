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
  @EnvironmentObject var appState: AppState
  private var lastSession: Session? {
    if let lastSession = Session.getLastNotFinishedSession(context: PersistentStore.shared.context) {
      return lastSession
    } else {
      return nil
    }
  }
  @State private var isAnimating: Bool = false

  let animationDelay = 0.25

  var body: some View {
    NavigationView {
      ZStack {
        Color.primaryBackground
          .ignoresSafeArea()

        VStack {
          Logo()
          Spacer(minLength: 20)
          VStack(spacing: 15) {
            if let lastSession = lastSession {
              PushStyledNavigationLink(title: L10n.HomeView.resume) {
                SessionMainView(viewModel: SessionViewModel(lastSession: lastSession))
              }
              .offset(y: isAnimating ? 0 : 800)
              .animation(.easeInOut(duration: 0.4), value: isAnimating)
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
        .navigationBarHidden(true)
        .tint(Color.primaryAccentColor)
        .onAppear {
          isAnimating = true
        }
        .overlay(settingsButton, alignment: .topTrailing)
      }
    }

    .pageSheet(isPresented: $showSettings) {
      SettingsView()
        .sheetPreference(.grabberVisible(true))
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
      Button("\(Image(systemSymbol: .wrenchAndScrewdriverFill))") {
        showSettings.toggle()
      }
      .buttonStyle(.circularOffsetStyle)
      .padding([.top, .trailing])
  }
}
