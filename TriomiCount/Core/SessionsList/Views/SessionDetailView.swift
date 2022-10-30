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
  @State private var chartData: [ChartTurnData] = []
  @State private var showSessionDeleteAlert: Bool = false

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
          let maxScore = chartData.max { $1.score > $0.score }?.score ?? 0

          Chart {
            ForEach(chartData, id: \.turnNumber) { turn in
              PointMark(
                x: .value(L10n.SessionDetailView.turn, turn.turnNumber),
                y: .value(L10n.SessionDetailView.points, turn.isAnimating ? turn.score : 0)
              )
              .foregroundStyle(by: .value("Player", turn.player))
            }

            ForEach(chartData, id: \.turnNumber) { turn in
              LineMark(
                x: .value(L10n.SessionDetailView.turn, turn.turnNumber),
                y: .value(L10n.SessionDetailView.points, turn.isAnimating ? turn.score : 0)
              )
              .foregroundStyle(by: .value("Player", turn.player))
              .interpolationMethod(.catmullRom)
            }
          }
          .frame(height: 300)
          .chartYScale(domain: 0...(maxScore + 10))
        }

        deleteSessionBtn
      }
      .padding(.horizontal)
    }
    .gradientBackground()
    .navigationTitle("Session #\(session.sessionCounter)")
    .roundedNavigationTitle()
    .onAppear {
      prepareChartData()
      animateChart()
    }
  }

  init(session: Session) {
    self.session = session
    self.sessionScores = Array(SessionScoreService.getScores(of: session))
  }
}

extension SessionDetailView {
  struct ChartTurnData {
    let turnNumber: Int
    let score: Int
    let player: String
    var isAnimating: Bool = false
  }

  private func prepareChartData() {
    var counter = 1
    session.turnsArray.forEach { turn in
      let turnData = ChartTurnData(turnNumber: counter,
                                   score: Int(turn.playersScoreTilNow),
                                   player: turn.playerName ?? "Unknown Player")
      chartData.append(turnData)
      counter += 1
    }
  }

  private func animateChart() {
    for (index, _) in chartData.enumerated() {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
          chartData[index].isAnimating = true
        }
      }
    }
  }
}

extension SessionDetailView {
  private var deleteSessionBtn: some View {
    Button(L10n.SessionDetailView.DeleteSession.buttonTitle, role: .destructive) {
      showSessionDeleteAlert = true
    }
    .buttonStyle(ShadowedStyle(role: .destructive))
    .padding(.horizontal, 50)
    .padding(.vertical)
    .alert(L10n.SessionDetailView.DeleteSession.alertTitle,
           isPresented: $showSessionDeleteAlert, actions: {
      Button(L10n.SessionDetailView.DeleteSession.confirmationButtonTitle, role: .destructive) {
        deleteSession()
      }
    }, message: {
      Text(L10n.SessionDetailView.DeleteSession.alertMessage)
    })
  }

  private func deleteSession() {
    do {
      try SessionService.delete(session)
      dismiss()
    } catch {
      print("Can't delete session!", error)
    }
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
