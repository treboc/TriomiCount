//
//  AboutView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.04.22.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack(spacing: 10) {
      Text("Made with ☕️ and 💚 by")
        .font(.subheadline.bold())
      Text("Marvin Lee")
        .font(.subheadline)
      Text("Version 1.0.0")
        .font(.caption)

      HStack(spacing: 20) {
        Image("github-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 32, height: 32)

        Link("treboc @ GitHub", destination: Constants.githubURL)
      }

      HStack(spacing: 20) {
        Image("twitter-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 32, height: 32)

        Link("treb0c @ Twitter", destination: Constants.twitterURL)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    .tint(.accentColor)
    .ignoresSafeArea()
    .gradientBackground()
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
