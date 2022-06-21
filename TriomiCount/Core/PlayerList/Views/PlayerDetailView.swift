//
//  PlayerDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//
import SwiftUI

struct PlayerDetailView: View {
  let player: Player
  @Environment(\.dismiss) private var dismiss
  @State private var showDeletePlayerAlert: Bool = false

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack {
        PlayerInitialsCircle(player: player)

        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            PlayerDetailSection(L10n.PlayerDetailView.highscore) {
              "\(player.wrappedHighscore)"
            }
            PlayerDetailSection(L10n.PlayerDetailView.lastScore) {
              "\(player.wrappedLastScore)"
            }
            PlayerDetailSection(L10n.PlayerDetailView.createdOn) {
              "\(player.wrappedCreatedOn.formatted(date: .abbreviated, time: .omitted))"
            }
            PlayerDetailSection(L10n.PlayerDetailView.numberOfSessionsWon) {
              "\(player.sessionsWon)"
            }
            PlayerDetailSection(L10n.PlayerDetailView.numberOfSessionsPlayed) {
              "\(player.sessionsPlayed)"
            }

            Button(L10n.PlayerDetailView.DeleteButton.title, role: .destructive) {
              showDeletePlayerAlert.toggle()
            }
            .buttonStyle(OffsetStyle(role: .destructive))
            .padding(.horizontal, 50)
          }
          .padding(.horizontal, 20)
        }
      }
      .padding(.vertical)
      .alert(L10n.PlayerDetailView.DeletePlayer.alertTitle, isPresented: $showDeletePlayerAlert, actions: {
        Button(L10n.PlayerDetailView.DeletePlayer.confirmationButtonTitle, role: .destructive) { deletePlayerAndDismissView() }
      }, message: {
        Text(L10n.PlayerDetailView.DeletePlayer.alertMessage(player.wrappedName))
      })
    }
    .navigationBarTitleDisplayMode(.inline)
  }

  func deletePlayerAndDismissView() {
    Player.deletePlayer(player)
    dismiss()
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
      .foregroundColor(.primary)
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity, maxHeight: 60)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.ultraThinMaterial)
          .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
      )
      .padding(.top, 5)
    }
  }

  struct PlayerInitialsCircle: View {
    let player: Player

    var body: some View {
      VStack {
        Circle()
          .fill(
            LinearGradient(colors: [
              Color(uiColor: player.wrappedFavoriteColor),
              Color(uiColor: player.wrappedFavoriteColor.shade(.dark))
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
          )
          .overlay(
            Text(player.wrappedName.initials)
              .font(.largeTitle)
              .foregroundColor(player.wrappedFavoriteColor.isDarkColor ? .white : .black)
          )
          .frame(width: 100, height: 100)
          .overlay(
            Circle()
              .strokeBorder(.primary, lineWidth: 2)
          )
        Text(player.wrappedName)
      }
    }
  }
}
