//
//  GameView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var vm: GameViewModel
    @State private var playerScore: Int = 0
    @State private var scoreSliderValue: Float = 0
    @State private var drawn: Bool = false
    @State private var timesDrawn: Int = 1
    @State private var playedCard: Bool = false
    
    private var showTimesDrawnView: Bool {
        return drawn
    }
    
    private var showPlayedCardView: Bool {
        return timesDrawn == 3 && drawn
    }
    
    private var calculatedScore: Int {
        var calculatedScore = self.scoreSliderValue
        
        if drawn && timesDrawn != 3 {
            calculatedScore = Float(scoreSliderValue) - Float(timesDrawn * 5)
        }
        
        if drawn && timesDrawn == 3 && playedCard {
            calculatedScore = scoreSliderValue - 15
        }
        
        if drawn && timesDrawn == 3 && !playedCard {
            calculatedScore = -25
        }
        
        return Int(calculatedScore)
    }
    
    // Exiting Game Alert
    @Environment(\.dismiss) private var dismiss
    @State private var showExitGameAlert: Bool = false
    
    //MARK: Body
    var body: some View {
        VStack(spacing: 10) {
            playerLabel
                .padding(.bottom, 30)
            
            slider
            
            drawnToggle
            
            if drawn {
                timesDrawnView
                    .transition(.slide)
            } else {
                timesDrawnView.hidden()
            }
            
            if timesDrawn == 3 && drawn {
                playedCardView
                    .transition(.slide)
            } else {
                playedCardView.hidden()
            }
            
            Spacer()
            
            scoreLabel
            
            submitButton
            
            HStack {
                exitGameButton
                submitButton
            }
        }
        .alert("Are you sure you want to exit the game? The state of the game is not saved!", isPresented: $showExitGameAlert, actions: {
            Button("Yes, I'm sure!", action: { dismiss() })
            Button("Cancel", role: .cancel, action: {})
        })
        .onAppear(perform: vm.startGame)
        .onAppear(perform: resetUIState)
        .tint(.accentColor)
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel())
    }
}

extension GameView {
    //MARK: UI Components
    private var playerLabel: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(vm.playerOnTurn.name)
                .font(.title)
            Text("Score: \(vm.playerOnTurn.score)")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var drawnToggle: some View {
        Toggle("Have you drawn?", isOn: $drawn
                .animation(.default))
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            .onChange(of: drawn) { _ in
                resetToggles()
            }
    }
    
    private var timesDrawnView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Times drawn:")
            Picker("How many times did you draw?", selection: $timesDrawn.animation(.default)) {
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
            }
            .pickerStyle(.segmented)
            
        }
        .padding()
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var playedCardView: some View {
        Toggle("Were you able to play out your card?", isOn: $playedCard)
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    private var slider: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("How many points are on your card?")
            Slider(value: $scoreSliderValue, in: 0...15, step: 1)
            Text("\(String(format: "%.0f", scoreSliderValue)) Points")
        }
        .padding()
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var scoreLabel: some View {
        Text("Points for turn: \(calculatedScore)")
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    private var submitButton: some View {
        Button {
            vm.nextPlayer(currenTurnScore: self.calculatedScore)
            resetUIState()
        } label: {
            Text("Submit Score")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private var exitGameButton: some View {
        Button {
            showExitGameAlert.toggle()
        } label: {
            Text("Exit Game")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

}

extension GameView {
    //MARK: - Functions
    private func resetUIState() {
        scoreSliderValue = 0
        drawn = false
        timesDrawn = 1
        playedCard = false
    }
    
    private func resetToggles() {
        if !drawn {
            timesDrawn = 1
            playedCard = false
        }
    }
}
