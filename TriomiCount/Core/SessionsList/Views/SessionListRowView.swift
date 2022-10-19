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
    .frame(maxWidth: .infinity)
    .padding()
    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
  }
}
