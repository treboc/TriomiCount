//
//  SessionDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 31.03.22.
//

import CoreData
import SwiftUI
import Charts

struct ChartTurnData {
  let id: Int
  let score: Int
}

struct SessionDetailView: View {
  @Environment(\.dismiss) var dismiss
  let session: Session
  var sessionScores: [Dictionary<String, Int16>.Element]

  var body: some View {
    VStack(alignment: .center) {
      ScrollView {
        SessionDetailSection(L10n.SessionDetailView.playedWith) {
          Text(session.playedBy())
            .multilineTextAlignment(.leading)
        }

        if session.winner != nil {
          SessionDetailSection(L10n.SessionDetailView.won) {
            Text(session.winner ?? "Unknown")
          }
        }

        SessionDetailSection(L10n.SessionDetailView.turnOverview) {
          Chart {
            ForEach(0..<session.turnsArray.count, id: \.self) { index in
              BarMark(
                x: .value(L10n.SessionDetailView.turn, index),
                y: .value(L10n.SessionDetailView.points, session.turnsArray[index].playersScoreTilNow)
              )
              .foregroundStyle(by: .value("Player", session.turnsArray[index].wrappedPlayerName))
            }
          }
          .frame(height: 300)
        }

        SessionDetailSection(L10n.SessionDetailView.points) {
          VStack(alignment: .leading) {
            ForEach(sessionScores.sorted { $0.value > $1.value }, id: \.key) { key, value in
              HStack {
                Text(key)
                  .frame(minWidth: 50, alignment: .leading)
                Spacer()
                Text("\(value)")
                  .frame(minWidth: 50, alignment: .trailing)
              }
            }
          }
        }
      }
      .padding(.horizontal)

      Spacer()
    }
    .gradientBackground()
    .navigationTitle("Session #\(session.sessionCounter)")
    .roundedNavigationTitle()
  }

  init(session: Session) {
    self.session = session
    self.sessionScores = Array(SessionScoreService.getScores(of: session))
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
        VStack(alignment: .leading, spacing: 0) {
          Text(sectionTitle.uppercased())
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.bottom, 2)
          content
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
