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
  @State private var newPlayerSheedIsShown: Bool = false

  @FetchRequest(fetchRequest: Player.allPlayersFR(), animation: .default)
  var players: FetchedResults<Player>

  var body: some View {
    ZStack {
      background

      VStack {
        header

        playerList

        if !viewModel.chosenPlayers.isEmpty {
          startSessionButton
        }
      }
      .onDisappear {
        viewModel.resetState(of: players)
      }
      .pageSheet(isPresented: $newPlayerSheedIsShown) {
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

extension SessionOnboardingView {
  private var background: some View {
    Color.primaryBackground
      .ignoresSafeArea()
  }

  private var header: some View {
    HeaderView(title: L10n.SessionOnboardingView.participationHeaderText) {
      Button(iconName: .arrowLeft) {
        dismiss()
      }
    } trailingButton: {
      Button(iconName: .plus) {
        newPlayerSheedIsShown = true
      }
    }
  }

  private var playerList: some View {
    ScrollView {
      ForEach(players) { player in
        SessionOnboardingRowView(player: player, position: viewModel.getPosition(ofChosenPlayer: player))
          .contentShape(Rectangle())
          .onTapGesture {
            withAnimation {
              viewModel.toggleIsChosenState(player)
            }
          }
          .padding(.horizontal)
      }
    }
  }

  private var startSessionButton: some View {
    PushStyledNavigationLink(title: L10n.SessionOnboardingView.startSession) {
      SessionMainView(viewModel: SessionViewModel(viewModel.chosenPlayers))
    }
    .buttonStyle(.offsetStyle)
    .foregroundColor(.primary)
    .padding()
    .frame(maxWidth: .infinity)
    .background(
      Rectangle()
        .fill(.regularMaterial)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(color: Color(uiColor: .black).opacity(0.5), radius: 8, x: 0, y: -2.5)
        .ignoresSafeArea(.all, edges: .bottom)
    )
    .transition(.move(edge: .bottom))
    .zIndex(1)
  }
}
