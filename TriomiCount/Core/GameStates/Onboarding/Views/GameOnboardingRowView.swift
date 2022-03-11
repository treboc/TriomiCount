//
//  NewGameChoosePlayerListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct GameOnboardingRowView: View {
    let player: Player
    let position: Int?
    
    var body: some View {
        ZStack {
            // Background, conditional on whether the row isChosen or not.
            !player.isChosen ? Color("SecondaryAccentColor")
            : Color("TertiaryAccentColor")
            
            HStack {
                ZStack {
                    Image(systemName: "circle.dotted")
                        .font(.title)
                    position != nil ? Text("\(position ?? 0)") : Text("")
                }
                .frame(width: 30, height: 30)
                
                Text("\(player.name)")
                Spacer()
                VStack(alignment: .center) {
                    Text("\(player.highscore)")
                    Text("Highscore")
                        .font(.caption)
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
        }
        .cornerRadius(10)
        .frame(height: 65)
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden)
        .accessibilityLabel("Player \(player.name), \(player.isChosen ? "is chosen" : "is not chosen")")
    }
}

struct NewGameChoosePlayerListRowView_Previews: PreviewProvider {
    static var previews: some View {
        GameOnboardingRowView(player: Player(context: PersistentStore.previewGameOnBoardingRowView.context), position: 1)
            .padding()
            .environment(\.managedObjectContext, PersistentStore.previewGameOnBoardingRowView.context)
    }
}

// MARK: - Preview Items
extension PersistentStore {
    static var previewGameOnBoardingRowView: PersistentStore = {
        let result = PersistentStore(inMemory: true)
        let viewContext = result.context
        let newPlayer = Player(context: viewContext)
        newPlayer.name = "Sad"
        try! viewContext.save()
        return result
    }()
}
