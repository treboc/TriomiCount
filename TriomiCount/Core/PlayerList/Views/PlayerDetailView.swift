//
//  PlayerDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//
import SwiftUI

struct PlayerDetailView: View {
  let player: Player
  //  @Environment(\.presentationMode) var presentationMode
  @Environment(\.dismiss) private var dismiss
  @State private var showDeletePlayerAlert: Bool = false

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(spacing: 20) {
        PlayerInitialsCircle(player: player)

        ScrollView(.vertical, showsIndicators: false) {
          PlayerDetailSection(L10n.PlayerDetailView.name) {
            player.wrappedName
          }
          PlayerDetailSection(L10n.PlayerDetailView.highscore) {
            "\(player.wrappedHighscore)"
          }
          PlayerDetailSection(L10n.PlayerDetailView.lastScore) {
            "\(player.wrappedLastScore)"
          }
          PlayerDetailSection(L10n.PlayerDetailView.createdOn) {
            "\(player.wrappedCreatedOn.formatted(date: .abbreviated, time: .omitted))"
          }
          PlayerDetailSection(L10n.PlayerDetailView.numberOfGamesWon) {
            "\(player.gamesWon)"
          }
          PlayerDetailSection(L10n.PlayerDetailView.numberOfGamesPlayed) {
            "\(player.gamesPlayed)"
          }
        }

        Spacer()

        HStack {
          Button(L10n.back) {
            dismiss()
          }
          .buttonStyle(.offsetStyle)

          Button(L10n.PlayerDetailView.DeleteButton.title, role: .destructive) {
            showDeletePlayerAlert.toggle()
          }
          .buttonStyle(OffsetOnTapStyle(role: .destructive))
        }
      }
      .padding([.horizontal, .top], 20)
      .padding(.bottom)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationTitle("")
      .navigationBarTitleDisplayMode(.inline)
      .alert(L10n.PlayerDetailView.DeletePlayer.alertTitle, isPresented: $showDeletePlayerAlert, actions: {
        Button(L10n.PlayerDetailView.DeletePlayer.confirmationButtonTitle, role: .destructive) { deletePlayerAndDismissView() }
      }, message: {
        Text(L10n.PlayerDetailView.DeletePlayer.alertMessage(player.wrappedName))
      })
      .navigationBarHidden(true)
    }
  }

  func deletePlayerAndDismissView() {
    Player.deletePlayer(player)
    dismiss()
  }
}

struct PlayerDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerDetailView(player: Player.allPlayers().first!)
      .environment(\.managedObjectContext, PersistentStore.preview.context)
  }
}

extension PlayerDetailView {
  struct PlayerDetailSection: View {
    let sectionTitle: String
    let sectionContent: String

    init(_ sectionTitle: String, content: () -> String) {
      self.sectionTitle = sectionTitle
      self.sectionContent = content()
    }

    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(sectionTitle.uppercased())
            .font(.caption)
          Spacer()
          Text(sectionContent)
        }
        Spacer()
      }
      .foregroundColor(.white)
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity, maxHeight: 60)
      .background(Color.secondaryBackground)
      .cornerRadius(10)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
      )
    }
  }

  struct PlayerInitialsCircle: View {
    let player: Player

    var body: some View {
      VStack {
        Circle()
          .foregroundColor(.green)
          .overlay(
            Text(player.wrappedName.initials)
              .font(.largeTitle)
          )
          .frame(width: 100, height: 100)
          .overlay(
            Circle()
              .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
          )
        Text(player.wrappedName)
      }
    }
  }
}
