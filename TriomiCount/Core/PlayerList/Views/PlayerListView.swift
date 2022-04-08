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
  @State private var searchTerm: String = ""
  @Environment(\.dismiss) private var dismiss

  @FetchRequest(sortDescriptors: PlayerListSort.default.descriptors, animation: .default)
  private var players: FetchedResults<Player>

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack {
        Text(LocalizedStringKey("Spieler"))
          .multilineTextAlignment(.center)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(10)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
          )
          .padding(.horizontal)

        ScrollView {
          ForEach(players) { player in
            NavigationLink {
              PlayerDetailView(player: player)
            } label: {
              PlayerListRowView(player: player)
            }
            .padding(.horizontal)
          }
        }

        VStack(spacing: 10) {
          Button("gameOnboardingView.button.add_new_player") {
            showAddPlayerPage.toggle()
          }

          Button("gameOnboardingView.button.back_to_main_menu") {
            dismiss()
          }
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal)
      }
      .pageSheet(isPresented: $showAddPlayerPage) {
        AddNewPlayerView()
          .sheetPreference(.detents([PageSheet.Detent.medium()]))
          .sheetPreference(.grabberVisible(true))
      }
      .navigationBarHidden(true)
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
