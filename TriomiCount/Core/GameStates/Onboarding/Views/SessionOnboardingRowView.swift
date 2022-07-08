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
  @State var angle: Angle = Angle(degrees: 0)

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(isChosen ? Color.primaryAccentColor.opacity(0.8) : Color.primaryAccentColor)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 3)

      HStack {
        ZStack {
          Image(systemSymbol: .circleDashed)
            .rotationEffect(.degrees(isChosen ? 360 : 0))
            .animation(isChosen
                       ? .linear(duration: 5).repeatForever(autoreverses: false)
                       : .default, value: isChosen)
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
