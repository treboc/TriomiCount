//
//  SessionOnboardingView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI
import PageSheetCore

struct SessionOnboardingView: View {
  @StateObject var viewModel: SessionOnboardingViewModel = SessionOnboardingViewModel()
  @Environment(\.dismiss) private var dismiss
  @State private var showAddPlayerPage: Bool = false

  @FetchRequest(fetchRequest: Player.allPlayersFR(), animation: .default)
  var players: FetchedResults<Player>

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack {
        Text(L10n.SessionOnboardingView.participationHeaderText)
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
            SessionOnboardingRowView(player: player, position: viewModel.getPosition(ofChosenPlayer: player))
              .contentShape(Rectangle())
              .onTapGesture { viewModel.toggleIsChosenState(player) }
              .padding(.horizontal)
          }
        }

        VStack(spacing: 10) {
          Button(L10n.SessionOnboardingView.addNewPlayer) {
            showAddPlayerPage.toggle()
          }

          PushStyledNavigationLink(title: L10n.SessionOnboardingView.startSession) {
            SessionMainView(viewModel: SessionViewModel(viewModel.chosenPlayers))
          }
          .disabled(viewModel.chosenPlayers.isEmpty)

          Button(L10n.SessionOnboardingView.backToMainMenu) {
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

struct SessionOnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationView {
        SessionOnboardingView()
          .navigationBarHidden(true)
          .preferredColorScheme(.dark)
      }

      NavigationView {
        SessionOnboardingView()
          .navigationBarHidden(true)
          .preferredColorScheme(.light)
      }
    }
  }
}
