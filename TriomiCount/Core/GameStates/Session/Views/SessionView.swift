//
//  SessionView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 19.03.22.
//

import Inject
import SwiftUI

struct SessionView: View {
  @ObservedObject var viewModel: SessionViewModel
  @EnvironmentObject var appState: AppState
  @AppStorage(SettingsKeys.idleDimmingDisabled) var idleDimmingDisabled: Bool = true

  @State private var sessionOverviewIsShown: Bool = false
  @State private var menuIsShown: Bool = false

  @State private var scale: CGFloat = 1

  var body: some View {
    ZStack(alignment: .top) {
      VStack(spacing: 0) {
        header
        Spacer(minLength: 10)
        center
        Spacer(minLength: 10)
        buttonStack
      }
      .animation(.easeIn(duration: 0.1), value: menuIsShown)
      .onAppear(perform: viewModel.resetTurnState)

      if sessionOverviewIsShown {
        SessionOverview(players: viewModel.session.playersArray) {
          withAnimation {
            sessionOverviewIsShown = false
          }
        }
        .zIndex(1)
        .transition(.move(edge: .top))
      }

      if menuIsShown {
        MenuOverlay(viewModel: viewModel,
                    menuIsShown: $menuIsShown,
                    exitSession: appState.exitSession,
                    toggleScaleAnimation: toggleScaleAnimation)
      }
    }
    .scaleEffect(scale)
    .alert(L10n.ExitSessionAlert.title, isPresented: $viewModel.showExitSessionAlert) {
      Button(L10n.cancel, role: .cancel) {}
      Button(action: { appState.exitSession() },
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
  }
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
    }
    .glassStyled()
    .animation(.none, value: viewModel.currentPlayerOnTurn)
    .overlay(sessionInfoButton.padding(.trailing), alignment: .topTrailing)
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
        .transition(.move(edge: .leading))
        .overlay(viewModel.turnHasChanges
          ? resetButton
          .scaleEffect(0.8)
          .transition(.opacity)
          .offset(y: -30) : nil, alignment: .topTrailing )
        .animation(.easeIn(duration: 0.2), value: viewModel.turnHasChanges)
      }

      if viewModel.bonusEventPickerOverlayIsShown {
        BonusEventPicker.SelectionOverlay(bonusEvent: $viewModel.bonusEvent, bonusEventPickerOverlayIsShown: $viewModel.bonusEventPickerOverlayIsShown)
          .transition(.move(edge: .trailing))
          .zIndex(1)
      }
    }
  }

  // MARK: - ButtonStack
  private var buttonStack: some View {
    HStack {
      nextPlayerButton
      menuButton
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
      BonusEventPicker(
        bonusEvent: $viewModel.bonusEvent,
        bonusEventPickerOverlayIsShown: $viewModel.bonusEventPickerOverlayIsShown
      )
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
      viewModel.endTurn()
      toggleScaleAnimation()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
  }

  private var menuButton: some View {
    Button(iconName: .squareStackFill) {
      withAnimation {
        menuIsShown.toggle()
      }
    }
    .frame(width: Constants.buttonHeight, height: Constants.buttonHeight)
    .buttonStyle(.circular)
  }

  private var resetButton: some View {
    Button {
      viewModel.resetTurnState()
    } label: {
      Image(systemSymbol: .arrowCounterclockwise)
    }
    .buttonStyle(.circular)
    .padding(5)
  }

  private var sessionInfoButton: some View {
    Image(systemSymbol: .infoCircle)
      .font(.title2)
      .onTapGesture {
        withAnimation {
          sessionOverviewIsShown.toggle()
        }
      }
      .padding([.top, .trailing])
      .blur(radius: menuIsShown ? 2 : 0)
  }

  struct SessionOverview: View {
    let players: [Player]
    let hideOverview: (() -> Void)

    var body: some View {
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
      .onTapGesture(perform: hideOverview)
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
    withAnimation(.linear(duration: 0.3)) {
      scale = 1.01
    }

    withAnimation(.linear.delay(0.3)) {
      scale = 1
    }
  }
}