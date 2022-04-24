//
//  GamesListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI
import CoreData

struct GamesListView: View {
  @Environment(\.dismiss) var dismiss
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Game.hasEnded, ascending: true)],
                animation: .default) private var games: FetchedResults<Game>

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack {
        Text(L10n.games)
          .multilineTextAlignment(.center)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
          )
          .padding(.horizontal)

        ScrollView {
          ForEach(games) { game in
            NavigationLink {
              GameDetailView(game: game)
            } label: {
              GameListRowView(game: game)
            }
            .padding(.horizontal)
          }
        }

        VStack(spacing: 10) {
          Button(L10n.backToMainMenu) {
            dismiss()
          }
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal)
      }
      .navigationBarHidden(true)
    }
  }

  struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
      GamesListView()
    }
  }
}
