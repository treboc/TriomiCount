//
//  PlayerListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import SwiftUI

struct PlayerListView: View {
    @State private var showAddNewPlayerView: Bool = false
    @State private var selectedSort: PlayerSort = .default
    
    @State private var searchTerm: String = ""

    var searchQuery: Binding<String> {
        Binding {
            searchTerm
        }
        set: { newValue in
            searchTerm = newValue
            
            guard !newValue.isEmpty else {
                players.nsPredicate = nil
                return
            }
            
            players.nsPredicate = NSPredicate(
                format: "name_ contains[cd] %@", newValue
            )
        }
    }
    
    @FetchRequest(sortDescriptors: PlayerSort.default.descriptors, animation: .default)
    private var players: FetchedResults<Player>
    
    var body: some View {
        ZStack {
            Color("SecondaryBackground")
                .ignoresSafeArea()
            
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
            .listStyle(.plain)
            .searchable(text: searchQuery, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search for Player")
            .navigationTitle("Player List")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    PlayerListSortView(
                        selectedSortItem: $selectedSort,
                        sorts: PlayerSort.sorts)
                        .onChange(of: selectedSort) { _ in
                            players.sortDescriptors = selectedSort.descriptors
                        }
                    
                    Button(action: {
                        showAddNewPlayerView.toggle()
                    }, label: {
                        Text("Add")
                    })
                }
            }
            .popover(isPresented: $showAddNewPlayerView) {
                AddNewPlayerView()
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

