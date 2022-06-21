//
//  PlayerListSortView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.02.22.
//

import SwiftUI
import SFSafeSymbols

struct PlayerListSortView: View {
  @Binding var selectedSortItem: PlayerListSort
  let sorts: [PlayerListSort] = PlayerListSort.sorts

  var body: some View {
    Menu {
      Picker("Sort By", selection: $selectedSortItem) {
        ForEach(0..<sorts.count, id: \.self) { index in
          SortMenuItem(sort: sorts[index]) { selectedSort in
            selectedSortItem = selectedSort
          }
          .tag(sorts[index])

          if index % 2 != 0 {
            Divider()
          }
        }
      }
    } label: {
      Label(
        "Sort",
        systemSymbol: .arrowUpArrowDown)
      .font(.system(.body, design: .rounded).bold())
    }
  }
}

extension PlayerListSortView {
  struct SortMenuItem: View {
    let sort: PlayerListSort
    let selectSort: ((PlayerListSort) -> Void)

    var body: some View {
      HStack {
        Text(sort.name)
        Spacer()
        sort.image
      }
      .onTapGesture {
        selectSort(sort)
      }
    }
  }
}

struct PlayerListSortView_Previews: PreviewProvider {
  @State static var sort = PlayerListSort.default

  static var previews: some View {
    PlayerListSortView(selectedSortItem: $sort)
  }
}
