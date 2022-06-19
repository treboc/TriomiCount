//
//  SessionsListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI
import CoreData

struct SessionsListView: View {
  @Environment(\.dismiss) var dismiss
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Session.hasEnded, ascending: true)],
                animation: .default) private var sessions: FetchedResults<Session>

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      scrollView
        .safeAreaInset(edge: .top, spacing: 10) {
          header
        }
        .navigationBarHidden(true)
    }
  }

  struct SessionsListView_Previews: PreviewProvider {
    static var previews: some View {
      SessionsListView()
    }
  }
}

extension SessionsListView {
  private var header: some View {
    HeaderView(title: L10n.sessions) {
      Button(iconName: .arrowLeft) {
        dismiss()
      }
    }
  }

  private var scrollView: some View {
    ScrollView(showsIndicators: false) {
      ForEach(sessions.filter { $0.hasEnded }) { session in
        NavigationLink {
          SessionDetailView(session: session)
        } label: {
          SessionListRowView(session: session)
        }
        .padding(.horizontal)
      }
    }
  }
}
