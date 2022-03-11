//
//  MainMenuView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import PageSheet

struct HomeView: View {
  @State private var showSettingsView: Bool = false
  @EnvironmentObject var appState: AppState
  @AppStorage("isDarkMode") private var isDarkMode: Bool = true
  
  @State private var logoIsAnimated: Bool = true
  
  @State private var lastSession: Game?
  
  var body: some View {
    NavigationView {
      ZStack {
        // Background Layer
        Color("SecondaryBackground")
          .ignoresSafeArea()
        
        // Foreground Layer
        VStack {
          settingsButton
          
          VStack(spacing: 30) {
            
            Spacer()
            
            LogoBackground()
            
            Spacer(minLength: 20)
            
            if lastSession != nil {
              PrimaryNavigationLink(destinationView: GameView(vm: GameViewModel(game: lastSession)), labelTextStringKey: "navigation_link.resume")
            }
            
            PrimaryNavigationLink(destinationView: GameOnboardingView(), labelTextStringKey: "navigation_link.new_game")
            
            PrimaryNavigationLink(destinationView: PlayerListView(), labelTextStringKey: "navigation_link.players")
            
            PrimaryNavigationLink(destinationView: GamesListView(), labelTextStringKey: "navigation_link.games")
            
            Spacer()
          }
          .navigationBarHidden(true)
          .tint(Color("AccentColor"))
        }
        .onAppear {
          lastSession = Game.getLastNotFinishedSession(context: PersistentStore.shared.context)
        }
        
      }
    }
    .pageSheet(isPresented: $showSettingsView) {
      SettingsView(isDarkMode: $isDarkMode)
        .sheetPreference(.grabberVisible(true))
    }
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HomeView()
        .previewDevice("iPhone 12")
        .preferredColorScheme(.light)
        .previewInterfaceOrientation(.portrait)
      
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
      Button {
        showSettingsView.toggle()
      } label: {
        Image(systemName: "wrench.and.screwdriver.fill")
          .padding(8)
          .overlay {
            Circle()
              .strokeBorder(lineWidth: 2, antialiased: true)
          }
      }
      .accessibilityLabel("Settings")
    }
    .padding([.trailing, .top], 10)
  }
}


