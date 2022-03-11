//
//  NewGameChoosePlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct GameOnboardingView: View {
  @StateObject var vm: GameOnboardingViewModel = GameOnboardingViewModel()
  @Environment(\.dismiss) private var dismiss
  @State private var sheetIsPresented: Bool = false
  
  @FetchRequest(fetchRequest: Player.allPlayersFR(), animation: .default)
  var players: FetchedResults<Player>
  
  var body: some View {
    ZStack {
      Color("SecondaryBackground")
        .ignoresSafeArea()
      
      VStack {
        Text(LocalizedStringKey("gameOnboardingView.participationHeaderText"))
          .multilineTextAlignment(.center)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color(UIColor.quaternaryLabel))
          .cornerRadius(10)
          .padding(.horizontal)
          .listRowSeparator(.hidden)
        
        ScrollView {
          ForEach(players) { player in
            GameOnboardingRowView(player: player, position: vm.getPosition(ofChosenPlayer: player))
              .contentShape(Rectangle())
              .onTapGesture { vm.toggleIsChosenState(player) }
              .padding(.horizontal)
          }
        }
        
        CustomButton(title: "gameOnboardingView.button.add_new_player") {
          sheetIsPresented.toggle()
        }
        
        CustomNavLink(title: "gameOnboardingView.button.start_game", destination: GameView(vm: GameViewModel(vm.chosenPlayers)))
          .disabled(vm.chosenPlayers.isEmpty)
        
        CustomButton(title: "gameOnboardingView.button.back_to_main_menu") {
          dismiss()
        }
      }
      .padding(.vertical)
      .onDisappear {
        vm.resetState(of: players)
      }
      .tint(Color("AccentColor"))
      .popover(isPresented: $sheetIsPresented, arrowEdge: .top) {
        AddNewPlayerView()
      }
    }
    .navigationBarHidden(true)
  }
}

struct GameOnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    Group() {
      NavigationView {
        GameOnboardingView()
          .navigationBarHidden(true)
          .preferredColorScheme(.dark)
      }
      
      NavigationView {
        GameOnboardingView()
          .navigationBarHidden(true)
          .preferredColorScheme(.light)
      }
    }
  }
}
