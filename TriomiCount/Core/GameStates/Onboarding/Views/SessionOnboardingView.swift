//
//  SessionOnboardingView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct SessionOnboardingView: View {
  @StateObject var viewModel = SessionOnboardingViewModel()
  @FetchRequest(sortDescriptors: [], animation: .spring())
  var players: FetchedResults<Player>

  var body: some View {
    NavigationView {
      ZStack {
        VStack(spacing: 0) {
          resumeLastSessionButton
          RectangularDivider()
          playerList
        }
        .overlay(onboardingText)
      }
      .gradientBackground()
      .fullScreenCover(isPresented: $viewModel.sessionIsShown,
                       onDismiss: viewModel.checkForUnfinishedSession) {
        SessionMainView(session: viewModel.session!) }
        .navigationTitle(L10n.newSession)
        .roundedNavigationTitle()
        .toolbar(content: toolbarContent)
        .onDisappear {
          viewModel.resetState(of: players)
        }
        .sheet(isPresented: $viewModel.newPlayerSheetIsShown, content: AddNewPlayerView.init)
    }
  }
}

extension SessionOnboardingView {
  private var playerList: some View {
    ScrollView(showsIndicators: false) {
      ForEach(players) { player in
        SessionOnboardingRowView(
          name: player.wrappedName,
          position: PlayerService.getPosition(of: player, in: viewModel.chosenPlayers),
          isChosen: viewModel.isPlayerChosen(player)
        )
        .onTapGesture {
          viewModel.choose(player)
        }
        .padding(.horizontal)
      }
      .padding(.bottom, 20)
      .padding(.top, 10)
    }
  }

  @ViewBuilder
  private var onboardingText: some View {
    if players.count < 2 {
      Text(L10n.SessionOnboardingView.addTwoPlayers)
        .font(.system(.headline, design: .rounded))
        .padding(.horizontal, 100)
        .multilineTextAlignment(.center)
    }
  }

  @ViewBuilder
  private var resumeLastSessionButton: some View {
    Button(action: viewModel.startSession) {
      Text(viewModel.session != nil && viewModel.chosenPlayers.count < 2
           ? L10n.Button.resumeLastSession
           : L10n.Button.startNewSession
      )
      .font(.system(.headline, design: .rounded))
    }
    .buttonStyle(.shadowed)
    .padding(.horizontal)
    .padding(.bottom, 10)
    .disabled(viewModel.startSessionButtonIsDisabled)
  }

  @ToolbarContentBuilder
  func toolbarContent() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      AddPlayerToolbarButton(newPlayerSheetIsShown: $viewModel.newPlayerSheetIsShown)
    }
  }
}
