//
//  SessionsListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI
import CoreData

struct SessionsListView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Session.sessionCounter, ascending: false)],
                predicate: NSPredicate(format: "hasEnded == TRUE"),
                animation: .default)
  private var sessions: FetchedResults<Session>

  var body: some View {
    NavigationView {
      ZStack {
        if sessions.isEmpty {
          placeholder
        } else {
          sessionsList
        }
      }
      .gradientBackground()
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
  private var placeholder: some View {
    Text(L10n.SessionListView.noSessionInfo)
      .multilineTextAlignment(.center)
      .font(.system(.headline, design: .rounded, weight: .semibold))
      .padding()
      .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private var sessionsList: some View {
    ScrollView {
      ForEach(sessions) { session in
        NavigationLink(destination: SessionDetailView(session: session)) {
          SessionListRowView(session: session)
        }
        .padding(.horizontal)
        .buttonStyle(.plain)
        .foregroundColor(.accentColor)
      }
    }
    .scrollContentBackground(.hidden)
  }
}
