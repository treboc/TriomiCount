//
//  GameDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 31.03.22.
//

import CoreData
import Inject
import SwiftUI

struct GameDetailView: View {
  @Environment(\.dismiss) var dismiss
  let game: Game

  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.primaryBackground
      .ignoresSafeArea()

      VStack(alignment: .center) {
        HStack {
          Text(LocalizedStringKey("gameListRowView.session")) +
          Text(" #\(game.id)")
        }
        .font(.largeTitle)
        .padding()
        .frame(maxWidth: .infinity)

        GameDetailSection("Mitgespielt haben:") {
          Text(game.playedBy)
        }

        GameDetailSection("Gewonnen hat:") {
          Text(game.winner)
        }

        GameDetailSection("Punkte wie folgt:") {
          VStack(alignment: .leading) {
            ForEach(GameScoreDict.getGameScoreDictWith(gameKey: game.objectID.uriRepresentation().absoluteString)!) { dict in
              HStack {
                Text(dict.playerName)
                  .frame(minWidth: 50, alignment: .leading)
                Spacer()
                Text("\(dict.scoreValue)")
                  .frame(minWidth: 50, alignment: .trailing)
              }
            }
          }
        }

        Spacer()

        Button("gameOnboardingView.button.back_to_main_menu") {
          dismiss()
        }
        .buttonStyle(.offsetStyle)
      }
      .padding(.horizontal)
    }
    .enableInjection()
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
  }

#if DEBUG
  @ObservedObject private var iO = Inject.observer
#endif
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
      GameDetailView(game: Game.allGames().first!)
    }
}

extension GameDetailView {
  struct GameDetailSection<Content: View>: View {
    let sectionTitle: String
    let content: Content

    init(_ sectionTitle: String, @ViewBuilder content: () -> Content) {
      self.sectionTitle = sectionTitle
      self.content = content()
    }

    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(NSLocalizedString(sectionTitle, comment: "").uppercased())
            .font(.caption)
            .padding(.bottom, 2)
          content
            .padding(.leading, 10)
        }
        Spacer()
      }
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.secondaryBackground)
      .cornerRadius(20)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
      )
    }
  }

}
