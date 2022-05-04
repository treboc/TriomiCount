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
        Text(L10n.sessions)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
          )
          .padding(.horizontal)

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

        VStack(spacing: 10) {
          Button(L10n.backToMainMenu) {
            dismiss()
          }
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal)
      }
      .padding(.vertical)
      .navigationBarHidden(true)
    }
  }

  struct SessionsListView_Previews: PreviewProvider {
    static var previews: some View {
      SessionsListView()
    }
  }
}
