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

      playerList
        .safeAreaInset(edge: .top, spacing: 10) {
          header
        }
        .safeAreaInset(edge: .bottom, spacing: 10) {
          if viewModel.chosenPlayers.count > 1 {
            startSessionButton
          }
        }
    }
    .onDisappear {
      viewModel.resetState(of: players)
    }
    .pageSheet(isPresented: $newPlayerSheedIsShown, content: AddNewPlayerView.init)
    .navigationBarHidden(true)
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
    ScrollView(showsIndicators: false) {
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
    OffsetStyledNavigationLink(title: L10n.SessionOnboardingView.startSession) {
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
    .disabled(viewModel.chosenPlayers.count < 2)
  }
}
