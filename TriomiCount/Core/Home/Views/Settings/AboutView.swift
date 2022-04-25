//
//  AboutView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.04.22.
//

import SwiftUI

struct AboutView: View {
  let twitterUrl = URL(string: "https://twitter.com/v0gelfrey")!
  let githubUrl = URL(string: "https://github.com/vogelfrey")!

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack {
        HStack(alignment: .top, spacing: 15) {
          Image("myImage")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 120, height: 120)

          VStack(alignment: .leading, spacing: 5) {
            Text("Hello! 👋🏻")

            Text("Hier könnt ihr mehr über mich herausfinden:")
            Link("Twitter", destination: twitterUrl)
            Link("Github", destination: githubUrl)
          }
        }
        Spacer()
      }
    }
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
