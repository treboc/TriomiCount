//
//  PlayerDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct PlayerDetailView: View {
  let player: Player
  @Environment(\.presentationMode) var presentationMode
  @State private var showDeletePlayerAlert: Bool = false
  
  var body: some View {
    ZStack {
      Color("SecondaryBackground")
        .ignoresSafeArea()
      
      VStack(spacing: 20) {
        PlayerInitialsCircle(player: player)
        
        ScrollView(.vertical, showsIndicators: false) {
          PlayerDetailSection(sectionTitle: "playerDetailView.name", sectionContent: Text(player.name))
          PlayerDetailSection(sectionTitle: "playerDetailView.highscore", sectionContent: Text("\(player.highscore)"))
          PlayerDetailSection(sectionTitle: "playerDetailView.lastScore", sectionContent: Text("\(player.currentScore)"))
          PlayerDetailSection(sectionTitle: "playerDetailView.createdOn", sectionContent: Text("\(player.createdOn.formatted(date: .abbreviated, time: .omitted))"))
          PlayerDetailSection(sectionTitle: "playerDetailView.numberOfGamesWon", sectionContent: Text("\(player.gamesWon)"))
          PlayerDetailSection(sectionTitle: "playerDetailView.numberOfGamesPlayed", sectionContent: Text("\(player.gamesPlayed)"))
        }
        
        Spacer()
        
        deletePlayerButton
      }
      .padding([.horizontal, .top], 20)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationTitle("")
      .navigationBarTitleDisplayMode(.inline)
      .alert("Warning!", isPresented: $showDeletePlayerAlert, actions: {
        Button("Yes, I'm sure.", role: .destructive) { deletePlayerAndDismissView() }
      }, message: {
        Text("Are you sure that you want to delete \(player.name)? The data can't be restored.")
      })
    }
  }
  
  
  func deletePlayerAndDismissView() {
    Player.deletePlayer(player)
    presentationMode.wrappedValue.dismiss()
  }
}

struct PlayerDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerDetailView(player: Player.allPlayers().first!)
      .environment(\.managedObjectContext, PersistentStore.preview.context)
  }
}

extension PlayerDetailView {
  var deletePlayerButton: some View {
    Button("Delete Player", role: .destructive) {
      showDeletePlayerAlert.toggle()
    }
    .buttonStyle(.borderedProminent)
    .controlSize(.large)
  }
  
  struct PlayerDetailSection: View {
    let sectionTitle: String
    let sectionContent: Text
    
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(NSLocalizedString(sectionTitle, comment: "").uppercased())
            .font(.caption)
          Spacer()
          sectionContent
        }
        Spacer()
      }
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity, maxHeight: 60)
      .background(.ultraThinMaterial)
      .cornerRadius(10)
      .padding(.vertical, 3)
    }
  }
  
  struct PlayerInitialsCircle: View {
    let player: Player
    
    var body: some View {
      VStack {
        Circle()
          .foregroundColor(.green)
          .overlay(
            Text(player.name.getInitials())
              .font(.largeTitle)
          )
          .frame(width: 100, height: 100)
        Text(player.name)
      }
    }
  }
}
