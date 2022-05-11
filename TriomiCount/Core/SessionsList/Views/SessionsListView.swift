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

      VStack {
        header

        ScrollView {
          ForEach(sessions) { session in
            NavigationLink {
              SessionDetailView(session: session)
            } label: {
              SessionListRowView(session: session)
            }
            .padding(.horizontal)
          }
        }
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
    Text(L10n.sessions)
      .multilineTextAlignment(.center)
      .glassStyled()
      .overlay(
        Button(action: {
          dismiss()
        }, label: {
          Image(systemSymbol: .arrowBackward)
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.leading)
        }), alignment: .leading
      )

  }
}
