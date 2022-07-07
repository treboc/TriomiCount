//
//  SessionOnboardingView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI
import PageSheetCore

struct SessionOnboardingView: View {
  @StateObject var viewModel = SessionOnboardingViewModel()
  @State private var newPlayerSheetIsShown: Bool = false

  @State private var selectedSort: PlayerListSort = .default
  @FetchRequest(sortDescriptors: PlayerListSort.default.descriptors, animation: .spring())
  var players: FetchedResults<Player>

  var body: some View {
    NavigationView {
      ZStack {
        Background()

        VStack {
          resumeLastSessionButton
          Divider()
          playerList
        }
        .overlay(onboardingText)
      }
      .fullScreenCover(isPresented: $viewModel.sessionIsShown, onDismiss: viewModel.checkForUnfinishedSession) {
        SessionMainView(session: viewModel.session!)
      }
      .navigationTitle(L10n.HomeView.newSession)
      .roundedNavigationTitle()
      .toolbar(content: toolbarContent)
      .onDisappear {
        viewModel.resetState(of: players)
      }
      .onChange(of: players.count) { _ in viewModel.checkForUnfinishedSession() }
      .pageSheet(isPresented: $newPlayerSheetIsShown, content: AddNewPlayerView.init)
    }
    .tint(.primaryAccentColor)
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
          viewModel.toggleIsChosenState(player)
        }
        .padding(.horizontal)
      }
    }
  }

  @ViewBuilder
  private var onboardingText: some View {
    if players.count < 2 {
      Text("Please add a minimum of two players, by tapping on the \(Image(systemSymbol: .plus)) on the top.")
        .font(.system(.headline, design: .rounded))
        .padding(.horizontal, 100)
        .multilineTextAlignment(.center)
    }
  }

  var buttonIsDisabled: Bool {
    if viewModel.session != nil && viewModel.chosenPlayers.count < 2 {
      return false
    } else if viewModel.chosenPlayers.count > 1 {
      return false
    } else {
      return true
    }
  }

  @ViewBuilder
  private var resumeLastSessionButton: some View {
    Button(action: viewModel.startSession) {
      Text(viewModel.session != nil && viewModel.chosenPlayers.count < 2
           ? L10n.HomeView.resumeLastSession
           : L10n.HomeView.startNewSession
      )
      .font(.system(.headline, design: .rounded))
    }
    .buttonStyle(.shadowed)
    .padding(.horizontal)
    .disabled(buttonIsDisabled)
  }

  @ToolbarContentBuilder
  func toolbarContent() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      AddPlayerToolbarButton(newPlayerSheetIsShown: $newPlayerSheetIsShown)
    }
  }
}
