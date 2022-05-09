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
  @State private var bgIsAnimated: Bool = false
  @State private var sessionOverviewIsShown: Bool = false

  var body: some View {
    ZStack {
      background
        .ignoresSafeArea()

      VStack(spacing: 0) {
        header
        Spacer(minLength: 10)
        center
        Spacer(minLength: 10)
        buttonStack
      }
      .blur(radius: sessionOverviewIsShown ? 2 : 0)
      .scaleEffect(sessionOverviewIsShown ? 0.95 : 1)
      .scaleEffect(isAnimated ? 1.05 : 1.0)
      .onAppear(perform: viewModel.resetTurnState)
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

      if sessionOverviewIsShown {
        SessionOverview(players: viewModel.session.playersArray)
          .zIndex(1)
          .transition(.move(edge: .top))
          .onTapGesture {
            withAnimation {
              sessionOverviewIsShown.toggle()
            }
          }
      }
    }
    .animation(.default, value: isAnimated)
    .enableInjection()
  }

#if DEBUG
  @ObservedObject private var iO = Inject.observer
#endif
}

extension SessionView {
  // MARK: - Header
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
      .overlay(
        Image(systemSymbol: .infoCircle).font(.headline)
          .onTapGesture {
            withAnimation {
              sessionOverviewIsShown.toggle()
            }
          }, alignment: .center
      )
    }
    .glassStyled()
    .animation(.none, value: viewModel.currentPlayerOnTurn)
  }

  // MARK: - Center
  private var center: some View {
    ZStack {
      if !viewModel.bonusEventPickerOverlayIsShown {
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
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(.thinMaterial)
            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
        )
        .overlay( viewModel.turnHasChanges ? circularResetButton.scaleEffect(0.5) : nil, alignment: .topTrailing )
        .padding(.horizontal)
        .transition(.move(edge: .leading))
      }

      if viewModel.bonusEventPickerOverlayIsShown {
        BonusEventPicker.SelectionOverlay(viewModel: viewModel)
          .transition(.move(edge: .trailing))
          .zIndex(1)
      }
    }
  }

  private var buttonStack: some View {
    VStack {
      nextPlayerButton
      HStack {
        exitSessionButton
        endSessionButton
      }
    }
    .padding([.horizontal, .bottom])
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

    var body: some View {
      ZStack(alignment: .top) {
        Color.black.opacity(0.001)

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
        .frame(maxWidth: .infinity)
        .padding()
        .background(
          Rectangle()
            .fill(.ultraThinMaterial)
            .cornerRadius(20, corners: [.bottomRight, .bottomLeft])
            .shadow(color: .black, radius: 5, x: 0, y: 2.5)
            .ignoresSafeArea(.all, edges: .top)
        )
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

extension SessionView {
  private var background: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()
        .overlay(
          Circle()
            .fill(.pink)
            .frame(width: 150, height: 150)
            .blur(radius: 50), alignment: bgIsAnimated ? .topLeading : .bottomLeading
        )
        .overlay(
          Circle()
          .fill(.purple)
          .frame(width: 150, height: 150)
          .blur(radius: 50), alignment: bgIsAnimated ? .bottomTrailing : .topTrailing
        )
        .animation(.easeIn(duration: 10).repeatForever(autoreverses: true), value: bgIsAnimated)
    }
    .onAppear { bgIsAnimated.toggle() }
  }
}
