//
//  PlayerListSortView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.02.22.
//

import SwiftUI

struct PlayerListSortView: View {
    @Binding var selectedSortItem: PlayerListSort
    let sorts: [PlayerListSort]
    
    var body: some View {
        Menu {
            Picker("Sort By", selection: $selectedSortItem) {
                ForEach(sorts, id: \.self) { sort in
                    Text("\(sort.name)")
                }
            }
        } label: {
            Label(
                "Sort",
                systemImage: "line.horizontal.3.decrease.circle")
        }
    }
}

struct PlayerListSortView_Previews: PreviewProvider {
    @State static var sort = PlayerListSort.default
    
    static var previews: some View {
        PlayerListSortView(selectedSortItem: $sort, sorts: PlayerListSort.sorts)
    }
}
