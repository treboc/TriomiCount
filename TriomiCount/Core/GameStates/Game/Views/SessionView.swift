//
//  SessionView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 19.03.22.
//

import Inject
import SwiftUI

struct SessionView: View {
  @StateObject var viewModel: SessionViewModel
  @EnvironmentObject var appState: AppState
  @AppStorage(SettingsKeys.idleDimmingDisabled) var idleDimmingDisabled: Bool = true
  @State private var isAnimated: Bool = false
  @State private var sessionOverviewIsShown: Bool = false
  private var overlayIsShown: Bool {
    return viewModel.bonusEventPickerOverlayIsShown || sessionOverviewIsShown
  }

  @State private var overlayIsShown2 = false

  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        header
        Spacer(minLength: 10)
        center
        Spacer(minLength: 10)
        VStack {
          nextPlayerButton
          HStack {
            exitSessionButton
            endSessionButton
          }
        }
      }
      .blur(radius: overlayIsShown ? 2 : 0)
      .animation(.none, value: overlayIsShown)

      .allowsHitTesting(overlayIsShown ? false : true)
      .scaleEffect(isAnimated ? 1.05 : 1.0)
      .onAppear(perform: viewModel.resetTurnState)
      .tint(.primaryAccentColor)
      .padding()
      .alert(L10n.ExitSessionAlert.title, isPresented: $viewModel.showExitSessionAlert) {
        Button(L10n.cancel, role: .cancel) {}
        Button(action: { exitSession() },
               label: { Text(L10n.ExitSessionAlert.buttonTitle) }
        )
      } message: {
        Text(L10n.ExitSessionAlert.message)
      }
      .confirmationDialog(L10n.EndSessionConfirmationDialogue.title, isPresented: $viewModel.showEndSessionAlert, titleVisibility: .visible) {
        Button(action: { viewModel.sessionWillEnd() },
               label: { Text(L10n.EndSessionConfirmationDialogue.messageWinner(viewModel.currentPlayerOnTurn?.wrappedName ?? "Unknown")) }
        )
        Button(L10n.EndSessionConfirmationDialogue.messageTie) {
          viewModel.isTie = true
          viewModel.sessionWillEnd()
        }
      }
      .onAppear {
        if idleDimmingDisabled {
          UIApplication.shared.isIdleTimerDisabled = true
        }
      }
      .onDisappear {
        UIApplication.shared.isIdleTimerDisabled = false
      }

      BonusEventPicker.SelectionOverlay(viewModel: viewModel)

      SessionOverview(players: viewModel.session.playersArray, sessionOverviewIsShown: $sessionOverviewIsShown)
        .offset(x: 0, y: sessionOverviewIsShown ? 0 : -800)
    }
    .animation(.default, value: isAnimated)
    .enableInjection()
  }

  #if DEBUG
  @ObservedObject private var iO = Inject.observer
  #endif
}

// MARK: UI Components
extension SessionView {
  private var header: some View {
    VStack(alignment: .center, spacing: 10) {
      Text(viewModel.currentPlayerOnTurn?.wrappedName ?? "Unknown")
        .font(.title)
        .bold()

      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text(L10n.SessionView.HeaderLabel.totalScore)
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(viewModel.currentPlayerOnTurn?.currentScore ?? 0)")
            .font(.subheadline)
        }
        .lineLimit(1)

        Spacer()

        VStack(alignment: .trailing, spacing: 5) {
          Text(L10n.SessionView.HeaderLabel.thisTurnScore)
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(viewModel.calculatedScore)")
            .font(.subheadline)
            .animation(.none, value: viewModel.calculatedScore)
        }
        .lineLimit(1)
      }
    }
    .foregroundColor(.white)
    .animation(.none, value: viewModel.currentPlayerOnTurn)
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color.secondaryBackground)
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
    )
    .onTapGesture {
      withAnimation {
        sessionOverviewIsShown.toggle()
      }
    }
  }

  private var center: some View {
    VStack(spacing: 10) {
      scoreSliderStack
      divider
      timesDrawnStack
      divider
      playedCardStack
      divider
      bonusEventStack
    }
    .padding()
    .frame(maxWidth: .infinity)
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
    )
    .overlay( circularResetButton.scaleEffect(0.8), alignment: .topTrailing )
  }

  private var scoreSliderStack: some View {
    VStack(alignment: .leading) {
      Text(L10n.SessionView.ScoreSlider.labelText)
        .font(.headline)

      HStack(spacing: 20) {
        Text(String(format: "%02d", Int(viewModel.scoreSliderValue)))
          .monospacedDigit()
          .frame(minWidth: 20)
        Slider(value: $viewModel.scoreSliderValue, in: 0...15, step: 1)
          .onChange(of: viewModel.scoreSliderValue) { _ in
            HapticManager.shared.impact(style: .light)
          }
          .tint(.primaryAccentColor)
      }
      .padding(.horizontal)
    }
  }

  private var timesDrawnStack: some View {
    VStack(alignment: .leading) {
      Text(L10n.SessionView.TimesDrawnPicker.labelText)
        .font(.headline)
      TimesDrawnPicker(selection: $viewModel.timesDrawn)
        .padding(.horizontal)
    }
  }

  private var playedCardStack: some View {
    VStack(alignment: .leading) {
      Text(L10n.SessionView.PlayedCardPicker.labelText)
        .font(.headline)
      PlayedCardPicker(selection: $viewModel.playedCard, timesDrawn: $viewModel.timesDrawn)
        .padding(.horizontal)
    }
  }

  private var bonusEventStack: some View {
    VStack(alignment: .leading) {
      Text(L10n.SessionView.BonusEventPicker.labelText)
        .font(.headline)
      BonusEventPicker(viewModel: viewModel)
        .padding(.horizontal)
    }
  }

  private var divider: some View {
    RoundedRectangle(cornerRadius: 1)
      .fill(Color.tertiaryBackground)
      .frame(height: 2)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 0)
  }

  private var nextPlayerButton: some View {
    Button(L10n.SessionView.NextPlayerButton.labelText) {
      viewModel.nextPlayer()
      toggleScaleAnimation()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
  }

  private var exitSessionButton: some View {
    Button(L10n.SessionView.ExitSessionButton.labelText) {
      if viewModel.session.turnsArray.count > 0 {
        viewModel.showExitSessionAlert.toggle()
      } else {
        exitSession()
      }
    }
    .buttonStyle(.offsetStyle)
  }

  private var endSessionButton: some View {
    Button(L10n.SessionView.EndSessionButton.labelText) {
      viewModel.showEndSessionAlert.toggle()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
    .disabled(viewModel.session.turns?.count == 0)
  }

  private var circularResetButton: some View {
    Button {
      viewModel.resetTurnState()
    } label: {
      Image(systemSymbol: .arrowCounterclockwise)
        .font(.title2.bold())
    }
    .buttonStyle(.circularOffsetStyle)
    .padding(5)
  }

  struct SessionOverview: View {
    let players: [Player]
    @Binding var sessionOverviewIsShown: Bool

    var body: some View {
      ZStack(alignment: .top) {
        Color.black.opacity(0.01).ignoresSafeArea()

        VStack {
          Text(L10n.sessionOverview)
            .font(.title2.bold())
            .padding(.bottom)

          HStack {
            Text(L10n.player)
            Spacer()
            Text(L10n.score)
          }
          .font(.title3.bold())

          divider

          ForEach(players.sorted(by: { $0.currentScore > $1.currentScore })) { player in
            HStack {
              Text(player.wrappedName)
              Spacer()
              Text("\(player.currentScore)")
            }
            .font(.title3)
          }
        }
        .padding(50)
        .frame(maxWidth: .infinity)
        .background(Color.primaryBackground)
        .cornerRadius(20)
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
        )
      }
      .padding(.horizontal)
      .onTapGesture {
        withAnimation {
          sessionOverviewIsShown = false
        }
      }
    }

    private var divider: some View {
      RoundedRectangle(cornerRadius: 1)
        .fill(Color.tertiaryBackground)
        .frame(height: 2)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 0)
    }
  }
}

// MARK: - UI Methods
extension SessionView {
  private func toggleScaleAnimation() {
    isAnimated = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isAnimated = false
    }
  }

  func exitSession() {
    appState.homeViewID = UUID()
    HapticManager.shared.impact(style: .medium)
  }
}
