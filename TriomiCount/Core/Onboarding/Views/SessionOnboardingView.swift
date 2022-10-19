//
//  SessionOnboardingView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct SessionOnboardingView: View {
  @StateObject private var viewModel = SessionOnboardingViewModel()
  @StateObject private var sessionPresentationManager = SessionPresentationManager()
  @FetchRequest(sortDescriptors: [], animation: .spring())
  var players: FetchedResults<Player>

  @ViewBuilder
  var body: some View {
    if sessionPresentationManager.sessionIsShown,
       let session = viewModel.session {
        SessionMainView(session: session)
          .environmentObject(sessionPresentationManager)
    } else {
      NavigationView {
        VStack(spacing: 0) {
          resumeLastSessionButton
          RectangularDivider()
          playerList
        }
        .overlay(onboardingText)
        .gradientBackground()
        .navigationTitle(L10n.newSession)
        .roundedNavigationTitle()
        .toolbar(content: toolbarContent)
        .onDisappear {
          viewModel.resetState(of: players)
        }
        .onAppear(perform: viewModel.checkForUnfinishedSession)
        .sheet(isPresented: $viewModel.newPlayerSheetIsShown, content: AddNewPlayerView.init)
      }
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
        .multilineTextAlignment(.center)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(.ultraThinMaterial)
            .shadow(radius: Constants.shadowRadius)
        )
        .padding(.horizontal, 50)
        .allowsHitTesting(false)
    }
  }

  @ViewBuilder
  private var resumeLastSessionButton: some View {
    Button {
      viewModel.startSession { sessionShouldShow in
        if sessionShouldShow {
          sessionPresentationManager.showSession()
        }
      }
    } label: {
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
