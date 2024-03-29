//
//  Logo.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.02.22.
//

import SwiftUI

struct Logo: View {
  let font: Font = Font.custom("PhotographSignature", fixedSize: 120)

  struct CurvedTriangle: Shape {
    let radius: CGFloat

    init(radius: CGFloat = 10) {
      self.radius = radius
    }

    func path(in rect: CGRect) -> Path {
      var path = Path()

      let point1 = CGPoint(x: rect.midX, y: 0)
      let point2 = CGPoint(x: rect.maxX, y: rect.maxY)
      let point3 = CGPoint(x: 0, y: rect.maxY)

      path.move(to: CGPoint(x: 0, y: rect.maxY))
      path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
      path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
      path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
      path.closeSubpath()
      return path
    }
  }

  var body: some View {
    ZStack {
      ZStack {
        CurvedTriangle()
          .fill(Color.primaryAccentColor)
          .shadow(radius: 5, x: 5, y: 5)

        VStack {
          Text("1")
            .rotationEffect(Angle(degrees: 180))
            .offset(y: 15)

          Spacer()

          HStack {
            Text("2")
              .rotationEffect(Angle(degrees: -300))
              .offset(x: 20, y: -5)
            Spacer()
            Text("3")
              .rotationEffect(Angle(degrees: 300))
              .offset(x: -20, y: -5)
          }
        }
        .font(.system(size: 18).bold())
        .foregroundColor(.white)
      }
      .frame(width: 300, height: 260)
      .offset(y: -30)

      Text("Triomi")
        .font(font)
        .shadow(color: .primary.opacity(0.8), radius: 10, x: 0, y: 0)
        .offset(x: 15, y: -50)

      Text("Count")
        .font(font)
        .shadow(color: .primary.opacity(0.8), radius: 10, x: 0, y: 0)
        .offset(x: 15, y: 30)
    }
    .offset(x: -20, y: 20)
    .rotationEffect(Angle(degrees: -20))
    .accessibilityHidden(true)
  }
}

struct LogoBackground_Previews: PreviewProvider {
  static var previews: some View {
    Logo()
  }
}
