//
//  PlayerListSortView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.02.22.
//

import SwiftUI

struct PlayerListSortView: View {
    @Binding var selectedSortItem: PlayerSort
    let sorts: [PlayerSort]
    
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
    @State static var sort = PlayerSort.default
    
    static var previews: some View {
        PlayerListSortView(selectedSortItem: $sort, sorts: PlayerSort.sorts)
    }
}
