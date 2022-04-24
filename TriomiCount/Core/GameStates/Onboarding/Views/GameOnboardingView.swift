//
//  NewGameChoosePlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI
import PageSheetCore

struct GameOnboardingView: View {
  @StateObject var viewModel: GameOnboardingViewModel = GameOnboardingViewModel()
  @Environment(\.dismiss) private var dismiss
  @State private var showAddPlayerPage: Bool = false

  @FetchRequest(fetchRequest: Player.allPlayersFR(), animation: .default)
  var players: FetchedResults<Player>

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack {
        Text(L10n.GameOnboardingView.participationHeaderText)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
          )
          .padding(.horizontal)

        ScrollView {
          ForEach(players) { player in
            GameOnboardingRowView(player: player, position: viewModel.getPosition(ofChosenPlayer: player))
              .contentShape(Rectangle())
              .onTapGesture { viewModel.toggleIsChosenState(player) }
              .padding(.horizontal)
          }
        }

        VStack(spacing: 10) {
          Button(L10n.GameOnboardingView.addNewPlayer) {
            showAddPlayerPage.toggle()
          }

          PushStyledNavigationLink(title: L10n.GameOnboardingView.startGame) {
            GameMainView(viewModel: GameViewModel(viewModel.chosenPlayers))
          }
          .disabled(viewModel.chosenPlayers.isEmpty)

          Button(L10n.GameOnboardingView.backToMainMenu) {
            dismiss()
          }
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal)
      }
      .padding(.vertical)
      .onDisappear {
        viewModel.resetState(of: players)
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
    Group {
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
