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
        if sessions.isEmpty {
          Text(L10n.SessionListView.noSessionInfo)
            .multilineTextAlignment(.center)
            .font(.system(.headline, design: .rounded, weight: .semibold))
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
            .padding()
        } else {
          sessionsList
        }
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
  private var sessionsList: some View {
    List {
      ForEach(sessions) { session in
        NavigationLink(destination: SessionDetailView(session: session)) {
          SessionListRowView(session: session)
        }
        .padding(.horizontal)
      }
    }
  }
}
