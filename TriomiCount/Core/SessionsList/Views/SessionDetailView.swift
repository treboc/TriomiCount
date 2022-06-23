//
//  SessionDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 31.03.22.
//

import CoreData
import SwiftUI

struct SessionDetailView: View {
  @Environment(\.dismiss) var dismiss
  let session: Session

  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(alignment: .center) {
        VStack {
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
              ForEach(
                SessionScore
                  .getSessionScoreDictWith(sessionKey: session.objectID.uriRepresentation().absoluteString)!
                  .sorted { $0.scoreValue > $1.scoreValue }) { dict in
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
        }
        .padding(.horizontal)
      }
    }
    .navigationTitle("Session #\(session.id)")
    .roundedNavigationTitle()
  }
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
      .foregroundColor(.primary)
      .multilineTextAlignment(.center)
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.ultraThinMaterial)
          .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
      )
      .padding(.top, 5)
    }
  }
}

extension SessionDetailView {
  fileprivate var header: some View {
    HeaderView(title: "Session #\(session.id)") {
      Button(iconName: .arrowLeft) {
        dismiss()
      }
    }
  }
}
