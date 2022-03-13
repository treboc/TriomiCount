//
//  NewGameChoosePlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI
import PageSheetCore

struct GameOnboardingView: View {
  @StateObject var vm: GameOnboardingViewModel = GameOnboardingViewModel()
  @Environment(\.dismiss) private var dismiss
  @State private var showAddPlayerPage: Bool = false
  
  @FetchRequest(fetchRequest: Player.allPlayersFR(), animation: .default)
  var players: FetchedResults<Player>
  
  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()
      
      VStack {
        Text(LocalizedStringKey("gameOnboardingView.participationHeaderText"))
          .multilineTextAlignment(.center)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(10)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
          )
          .padding(.horizontal)
        
        ScrollView {
          ForEach(players) { player in
            GameOnboardingRowView(player: player, position: vm.getPosition(ofChosenPlayer: player))
              .contentShape(Rectangle())
              .onTapGesture { vm.toggleIsChosenState(player) }
              .padding(.horizontal)
          }
        }

        VStack(spacing: 10) {
          Button("gameOnboardingView.button.add_new_player") {
            showAddPlayerPage.toggle()
          }

          CustomNavLink(title: "gameOnboardingView.button.start_game", destination: GameView(vm: GameViewModel(vm.chosenPlayers)))
            .disabled(vm.chosenPlayers.isEmpty)

          Button("gameOnboardingView.button.back_to_main_menu") {
            dismiss()
          }
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal)
      }
      .padding(.vertical)
      .onDisappear {
        vm.resetState(of: players)
      }
      .pageSheet(isPresented: $showAddPlayerPage) {
        AddNewPlayerView()
          .sheetPreference(.detents([PageSheet.Detent.medium()]))
          .sheetPreference(.grabberVisible(true))
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
