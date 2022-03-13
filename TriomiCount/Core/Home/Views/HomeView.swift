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
  @State private var showSettingsView: Bool = false
  @AppStorage("isDarkMode") private var isDarkMode: Bool = true
  
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
                PrimaryNavigationLink(destinationView: GameView(vm: GameViewModel(game: lastSession)), labelTextStringKey: "navigation_link.resume")
              }

              PrimaryNavigationLink(destinationView: GameOnboardingView(), labelTextStringKey: "navigation_link.new_game")

              PrimaryNavigationLink(destinationView: PlayerListView(), labelTextStringKey: "navigation_link.players")

              PrimaryNavigationLink(destinationView: GamesListView(), labelTextStringKey: "navigation_link.games")
            }
            .frame(maxWidth: .infinity)
//            .frame(height: UIScreen.main.bounds.height * 0.35)
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
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.portrait)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.xSmall)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.small)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.medium)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.large)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.xLarge)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.xxLarge)
      //      HomeView()
      //        .previewDevice("iPhone 12")
      //        .preferredColorScheme(.dark)
      //        .previewInterfaceOrientation(.portrait)
      //        .dynamicTypeSize(.xxxLarge)
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

