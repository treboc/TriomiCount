//
//  SessionMainView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import SFSafeSymbols

struct SessionMainView: View {
  let session: Session
  @StateObject var viewModel: SessionViewModel

  // MARK: Body
  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      switch viewModel.state {
      case .playing:
        SessionView()
      case .willEnd:
        ZStack {
          SessionView()
            .blur(radius: 10)
            .allowsHitTesting(false)
          PointsSubmitView()
        }
      case .didEnd:
        SessionResultsView()
      case .exited:
        Text("Exited")
          .onAppear { print("exited") }
      }
    }
    .environmentObject(viewModel)
    .navigationBarHidden(true)
  }

  init(session: Session) {
    self.session = session
    _viewModel = StateObject.init(wrappedValue: SessionViewModel(lastSession: session))
  }

}
