//
//  SessionDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 31.03.22.
//

import CoreData
import Inject
import SwiftUI

struct SessionDetailView: View {
  @Environment(\.dismiss) var dismiss
  let session: Session

  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.primaryBackground
      .ignoresSafeArea()

      VStack(alignment: .center) {
        HStack {
          Text("\(L10n.SessionListRowView.session) #\(session.id)")
        }
        .font(.title.bold())
        .padding()
        .frame(maxWidth: .infinity)

        SessionDetailSection(L10n.SessionDetailView.playedWith) {
          Text(session.playedBy)
            .multilineTextAlignment(.leading)
        }

        if session.winner != nil {
          SessionDetailSection(L10n.SessionDetailView.won) {
            Text(session.winner ?? "Unknown")
          }
        }

        SessionDetailSection(L10n.SessionDetailView.points) {
          VStack(alignment: .leading) {
            ForEach(SessionScore.getSessionScoreDictWith(sessionKey: session.objectID.uriRepresentation().absoluteString)!) { dict in
              HStack {
                Text(dict.playerName)
                  .frame(minWidth: 50, alignment: .leading)
                Spacer()
                Text("\(dict.scoreValue)")
                  .frame(minWidth: 50, alignment: .trailing)
              }
            }
          }
        }

        Spacer()

        Button(L10n.backToMainMenu) {
          dismiss()
        }
        .buttonStyle(.offsetStyle)
      }
      .padding()
    }
    .enableInjection()
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
  }

#if DEBUG
  @ObservedObject private var iO = Inject.observer
#endif
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
      SessionDetailView(session: Session.getAllSessions().first!)
    }
}

extension SessionDetailView {
  struct SessionDetailSection<Content: View>: View {
    let sectionTitle: String
    let content: Content

    init(_ sectionTitle: String, @ViewBuilder content: () -> Content) {
      self.sectionTitle = sectionTitle
      self.content = content()
    }

    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(sectionTitle.uppercased())
            .font(.caption)
            .padding(.bottom, 2)
          content
            .padding(.leading, 10)
        }
        Spacer()
      }
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.secondaryBackground)
      .foregroundColor(.white)
      .cornerRadius(20)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
      )
    }
  }

}
