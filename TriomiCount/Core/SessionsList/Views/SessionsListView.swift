//
//  SessionsListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI
import CoreData

struct SessionsListView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Session.hasEnded, ascending: false)],
                animation: .default) private var sessions: FetchedResults<Session>

  var body: some View {
    NavigationView {
      ZStack {
        Color.primaryBackground.ignoresSafeArea()
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
  private var scrollView: some View {
    ScrollView(showsIndicators: false) {
      ForEach(sessions.filter { $0.hasEnded }) { session in
        NavigationLink(destination: SessionDetailView(session: session)) {
          SessionListRowView(session: session)
        }
        .padding(.horizontal)
      }
    }
  }
}
