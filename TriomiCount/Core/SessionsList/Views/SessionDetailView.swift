//
//  SessionDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 31.03.22.
//

import CoreData
import SwiftUI
import Charts



struct SessionDetailView: View {
  @Environment(\.dismiss) var dismiss
  let session: Session
  var sessionScores: [Dictionary<String, Int16>.Element]
  @State private var barMarkWidth: CGFloat = 0

  @State private var chartData: [ChartTurnData] = []

  private func prepareChartData() {
    var counter = 1
    session.turnsArray.forEach { turn in
      let turnData = ChartTurnData(turnNumber: counter,
                                   score: Int(turn.playersScoreTilNow + turn.playersScoreInTurn),
                                   player: turn.playerName ?? "Unknown Player")
      chartData.append(turnData)
      counter += 1
    }
  }

  var body: some View {
    ScrollView {
      VStack {
        SessionDetailSection(L10n.SessionDetailView.playedWith) {
          Text(session.playedBy())
            .multilineTextAlignment(.leading)
        }

        if session.winner != nil {
          SessionDetailSection(L10n.SessionDetailView.won) {
            Text(session.winner ?? "Unknown")
          }
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

        SessionDetailSection(L10n.SessionDetailView.turnOverview) {
          Chart {
            ForEach(chartData) { turn in
              BarMark(
                x: .value(L10n.SessionDetailView.turn, turn.turnNumber),
                y: .value(L10n.SessionDetailView.points, turn.score),
                width: .fixed((barMarkWidth / Double(chartData.count)) - 10)
              )
              .foregroundStyle(by: .value("Player", turn.player))
            }
          }
          .frame(height: 300)
          .readSize { size in
            barMarkWidth = size.width
          }
        }
      }
      .padding(.horizontal)

      Spacer()
    }
    .gradientBackground()
    .navigationTitle("Session #\(session.sessionCounter)")
    .roundedNavigationTitle()
    .onAppear(perform: prepareChartData)
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

  struct ChartTurnData: Identifiable {
    var id: Int {
      turnNumber
    }
    let turnNumber: Int
    let score: Int
    let player: String
  }
}
