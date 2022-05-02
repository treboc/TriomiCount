//
//  AboutView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.04.22.
//

import SwiftUI

struct AboutSection: View {
  let twitterUrl = URL(string: "https://twitter.com/treb0c")!
  let githubUrl = URL(string: "https://github.com/treboc")!

  var body: some View {
    List {
      HStack(spacing: 20) {
        Image("github-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 32, height: 32)

        Link("treboc @ GitHub", destination: githubUrl)
      }

      HStack(spacing: 20) {
        Image("twitter-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 32, height: 32)

        Link("treb0c @ Twitter", destination: twitterUrl)
      }
    }
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutSection()
  }
}
