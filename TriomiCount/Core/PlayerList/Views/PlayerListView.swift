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
  @State private var showAddPlayerPage: Bool = false
  @State private var selectedSort: PlayerListSort = .default
  @Environment(\.dismiss) private var dismiss

  @FetchRequest(sortDescriptors: PlayerListSort.default.descriptors, animation: .default)
  private var players: FetchedResults<Player>

  var body: some View {
    ZStack {
      background

      scrollView
        .safeAreaInset(edge: .top, spacing: 10) {
          header
        }
    }
    .ignoresSafeArea(.container, edges: .bottom)
    .pageSheet(isPresented: $showAddPlayerPage) {
      AddNewPlayerView()
        .sheetPreference(.detents([PageSheet.Detent.medium()]))
        .sheetPreference(.cornerRadius(20))
        .sheetPreference(.grabberVisible(true))
    }
    .navigationBarHidden(true)
  }
}

extension PlayerListView {
  private var background: some View {
    Color.primaryBackground
      .ignoresSafeArea()
  }

  private var header: some View {
    HeaderView(title: L10n.players) {
      Button(iconName: .arrowLeft) {
        dismiss()
      }
    } trailingButton: {
      HStack(spacing: 15) {
        sortView
        Button(iconName: .plus) {
          showAddPlayerPage = true
        }
      }
    }
  }

  private var sortView: some View {
    PlayerListSortView(selectedSortItem: $selectedSort, sorts: PlayerListSort.sorts)
      .labelStyle(.iconOnly)
      .onChange(of: selectedSort) { _ in
        players.sortDescriptors = selectedSort.descriptors
      }
  }

  private var scrollView: some View {
    ScrollView(showsIndicators: false) {
      ForEach(players) { player in
        NavigationLink {
          PlayerDetailView(player: player)
        } label: {
          PlayerListRowView(player: player)
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal)
      }
      .padding(.bottom, 30)
    }
  }

  private var buttonStack: some View {
    VStack(spacing: 10) {
      Button(L10n.addNewPlayer) {
        showAddPlayerPage.toggle()
      }

      Button(L10n.backToMainMenu) {
        dismiss()
      }
    }
    .buttonStyle(.offsetStyle)
    .padding([.horizontal, .bottom])
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

// MARK: - Sorting & Adding New Player
//        .toolbar {
//          ToolbarItemGroup(placement: .navigationBarTrailing) {
//            PlayerListSortView(
//              selectedSortItem: $selectedSort,
//              sorts: PlayerListSort.sorts)
//              .onChange(of: selectedSort) { _ in
//                players.sortDescriptors = selectedSort.descriptors
//              }
//            Button("Add") {
//              showAddPlayerPage.toggle()
//            }
//            .frame(width: 50, height: 20)
//            .buttonStyle(.offsetStyle)
//          }
//        }
//  @State private var selectedSort: PlayerListSort = .default
//  @State private var searchTerm: String = ""
//
//  var searchQuery: Binding<String> {
//    Binding {
//      searchTerm
//    }
//    set: { newValue in
//      searchTerm = newValue
//
//      guard !newValue.isEmpty else {
//        players.nsPredicate = nil
//        return
//      }
//
//      players.nsPredicate = NSPredicate(
//        format: "name_ contains[cd] %@", newValue
//      )
//    }
//  }
//  .searchable(text: searchQuery, placement: .automatic, prompt: "Search for Player")
