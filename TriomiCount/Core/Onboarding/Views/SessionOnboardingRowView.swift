//
//  SessionOnboardingRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct SessionOnboardingRowView: View {
  let name: String
  let position: Int16?
  let isChosen: Bool
  @State private var phase = 0.0

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(isChosen ? Color.primaryAccentColor.opacity(0.8) : Color.primaryAccentColor)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
        .shadow(radius: Constants.shadowRadius)
        .overlay(isChosen ?
                 RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [10], dashPhase: phase), antialiased: true)
          .foregroundColor(.white)
                 : nil
        )
        .onChange(of: isChosen) { _ in
          withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
            phase -= 100
          }
        }

      HStack {
        ZStack {
          Image(systemSymbol: .circle)
            .font(.title)
          if let position = position {
            Text("\(position)")
          }
        }
        .monospacedDigit()
        .frame(width: 25, height: 25)

        Text("\(name)")
          .font(.system(.headline, design: .rounded))
        Spacer()
      }
      .padding(.horizontal)
      .foregroundColor(.white)
    }
    .listRowSeparator(.hidden)
    .animation(.none, value: position)
    .accessibilityLabel("Player \(name), \(isChosen ? "is chosen" : "is not chosen")")
  }
}
