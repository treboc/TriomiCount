//
//  PlayerListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import CoreData
import SwiftUI

struct PlayerListView: View {
  @State private var newPlayerSheetIsShown: Bool = false
  @State private var selectedSort: PlayerListSort = .lastCreated
  @Environment(\.dismiss) private var dismiss

  @FetchRequest(sortDescriptors: [], animation: .spring())
  private var players: FetchedResults<Player>

  var body: some View {
    NavigationView {
      ZStack {
        if players.isEmpty {
          placeholder
        } else {
          playerList
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .gradientBackground()
      .sheet(isPresented: $newPlayerSheetIsShown, content: AddNewPlayerView.init)
      .navigationTitle(L10n.players)
      .roundedNavigationTitle()
      .toolbar(content: toolbarContent)
    }
  }
}

extension PlayerListView {
  private var placeholder: some View {
    Text(L10n.PlayerListView.noPlayersInfo)
      .multilineTextAlignment(.center)
      .font(.system(.headline, design: .rounded, weight: .semibold))
      .padding()
      .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
      .padding()
  }

  private var playerList: some View {
    ScrollView(showsIndicators: false) {
      ForEach(players.filter { $0.wasDeleted == false }) { player in
        NavigationLink(destination: PlayerDetailView.init(player: player)) {
          PlayerListRowView(player: player)
        }
        .padding(.horizontal)
        .buttonStyle(.plain)
        .foregroundColor(.accentColor)
      }
    }
  }

  @ToolbarContentBuilder
  func toolbarContent() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      HStack(spacing: 15) {
        sortView
        AddPlayerToolbarButton(newPlayerSheetIsShown: $newPlayerSheetIsShown)
      }
    }
  }

  private var sortView: some View {
    PlayerListSortView(selectedSortItem: $selectedSort)
      .labelStyle(.iconOnly)
      .onChange(of: selectedSort) { _ in
        players.sortDescriptors = selectedSort.sortItem.descriptors
      }
  }
}

struct PlayerListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationView {
        PlayerListView()
          .preferredColorScheme(.dark)
      }

      NavigationView {
        PlayerListView()
          .preferredColorScheme(.light)
      }
    }
  }
}
