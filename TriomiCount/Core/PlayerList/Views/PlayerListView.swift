//
//  PlayerListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import CoreData
import SwiftUI
import PageSheet

struct PlayerListView: View {
  @State private var newPlayerSheetIsShown: Bool = false
  @State private var selectedSort: PlayerListSort = .default
  @Environment(\.dismiss) private var dismiss

  @FetchRequest(sortDescriptors: PlayerListSort.default.descriptors, animation: .spring())
  private var players: FetchedResults<Player>

  var body: some View {
    NavigationView {
      ZStack {
        Background()

        scrollView
      }
      .pageSheet(isPresented: $newPlayerSheetIsShown) {
        AddNewPlayerView()
      }
      .navigationTitle(L10n.players)
      .toolbar(content: toolbarContent)
      .roundedNavigationTitle()
    }
    .tint(.primaryAccentColor)
  }
}

extension PlayerListView {
  private var background: some View {
    LinearGradient(colors: [.primaryBackground.opacity(0.8), .primaryBackground.opacity(0.2)],
                   startPoint: .top,
                   endPoint: .bottom)
    .ignoresSafeArea()
  }

  private var sortView: some View {
    PlayerListSortView(selectedSortItem: $selectedSort)
      .labelStyle(.iconOnly)
      .onChange(of: selectedSort) { _ in
        players.sortDescriptors = selectedSort.descriptors
      }
  }

  private var scrollView: some View {
    ScrollView(showsIndicators: false) {
      ForEach(players) { player in
        NavigationLink(destination: PlayerDetailView.init(player: player)) {
          PlayerListRowView(player: player)
        }
        .buttonStyle(.shadowed)
        .padding(.horizontal)
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
