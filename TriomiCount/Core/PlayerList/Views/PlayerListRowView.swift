//
//  PlayerListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import SwiftUI

struct PlayerListRowView: View {
    let player: Player
    
    var body: some View {
        ZStack {
            Color("SecondaryAccentColor").opacity(0.5).cornerRadius(10)
            
            HStack {
                Text("\(player.name)")
                Spacer()
                VStack(alignment: .center) {
                    Text(player.highscore.roundedWithAbbreviations)
                    Text("Highscore")
                        .font(.caption)
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .frame(height: 65)
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden)
    }
}

struct PlayerListRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListRowView(player: Player(context: PersistentStore.preview.context))
            .environment(\.managedObjectContext, PersistentStore.preview.context)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
