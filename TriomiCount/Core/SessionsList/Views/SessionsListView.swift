//
//  SessionsListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI
import CoreData

struct SessionsListView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Session.id, ascending: false)],
                predicate: NSPredicate(format: "hasEnded == TRUE"),
                animation: .default)
  private var sessions: FetchedResults<Session>

  var body: some View {
    NavigationView {
      ZStack {
        Background()
        scrollView
      }
      .navigationTitle(L10n.sessions)
      .roundedNavigationTitle()
    }
  }

  struct SessionsListView_Previews: PreviewProvider {
    static var previews: some View {
      SessionsListView()
    }
  }
}

extension SessionsListView {
      ForEach(sessions) { session in
        NavigationLink(destination: SessionDetailView(session: session)) {
          SessionListRowView(session: session)
        }
        .padding(.horizontal)
      }
    }
  }
}
