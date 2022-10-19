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
        EmptyView()
      }
    }
    .gradientBackground()
    .environmentObject(viewModel)
    .toolbar(.hidden, for: .tabBar, .navigationBar)
  }

  init(session: Session) {
    self.session = session
    _viewModel = StateObject.init(wrappedValue: SessionViewModel(lastSession: session))
  }
}
