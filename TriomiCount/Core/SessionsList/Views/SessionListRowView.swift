//
//  SessionListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import Inject
import SwiftUI

struct SessionListRowView: View {
  let session: Session

  var body: some View {
    ZStack(alignment: .topLeading) {
      Color("SecondaryAccentColor")
        .opacity(1)
        .cornerRadius(20)

      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 3) {
          Text("\(L10n.SessionListRowView.session) #\(session.id)")
            .font(.headline.bold())

          HStack(alignment: .firstTextBaseline) {
            Text(L10n.SessionListRowView.playedBy)
              .bold()
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
    .enableInjection()
  }

#if DEBUG
  @ObservedObject private var iO = Inject.observer
#endif
}

struct SessionListRowView_Previews: PreviewProvider {
    static var previews: some View {
      SessionListRowView(session: Session.getAllSessions().first!)
    }
}
