//
//  SessionListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import SwiftUI

struct SessionListRowView: View {
  let session: Session

  var body: some View {
    ZStack(alignment: .topLeading) {
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(Color.primaryAccentColor)
        .shadow(radius: 5)

      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 3) {
          Text("\(L10n.SessionListRowView.session) #\(session.sessionCounter)")
            .font(.headline.bold())

          HStack(alignment: .firstTextBaseline) {
            Text(L10n.SessionListRowView.playedBy)
              .fontWeight(.semibold)
            Text(session.playedBy())
              .multilineTextAlignment(.leading)
          }
          .font(.subheadline)
        }

        Spacer()

        Text(session.startedOnAsString)
          .font(.caption)
      }
      .foregroundColor(.white)
      .padding(.horizontal)
      .padding(.vertical, 10)
    }
    .frame(maxWidth: .infinity)
    .listRowSeparator(.hidden)
  }
}
