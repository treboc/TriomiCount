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
        .fill(Color.primaryAccentColor.opacity(0.8))
        .shadow(color: .black, radius: 3, x: 0, y: 3)

      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 3) {
          Text("\(L10n.SessionListRowView.session) #\(session.id)")
            .font(.headline.bold())

          HStack(alignment: .firstTextBaseline) {
            Text(L10n.SessionListRowView.playedBy)
              .fontWeight(.semibold)
            Text(session.playedBy)
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

struct SessionListRowView_Previews: PreviewProvider {
    static var previews: some View {
      SessionListRowView(session: Session.getAllSessions().first!)
    }
}
