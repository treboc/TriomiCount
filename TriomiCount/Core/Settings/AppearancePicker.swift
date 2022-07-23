//
//  AppearancePicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 21.07.22.
//

import SwiftUI

struct AppearancePicker: View {
  @EnvironmentObject var appearanceManager: AppearanceManager
  @Environment(\.colorScheme) private var colorScheme

  func offset(_ proxy: GeometryProxy) -> CGFloat {
    switch appearanceManager.appearance {
    case .light:
      return proxy.size.width - (proxy.size.width / 3) * 3
    case .dark:
      return proxy.size.width - (proxy.size.width / 3) * 2
    case .system:
      return proxy.size.width - (proxy.size.width / 3)
    }
  }

  var body: some View {
    GeometryReader { proxy in
      HStack(spacing: 0) {
        ForEach(AppearanceManager.Appearance.allCases, id: \.self) { appearence in
          Text(appearence.title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
      }
      .overlay(alignment: .leading) {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(Color.primaryAccentColor)
          .overlay(alignment: .leading, content: {
            GeometryReader { _ in
              HStack(spacing: 0) {
                ForEach(AppearanceManager.Appearance.allCases, id: \.self) { appearance in
                  Text(appearance.title)
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(appearance == appearanceManager.appearance ? .white : .primary)
                    .contentShape(Rectangle())
                    .onTapGesture {
                      setAppearance(appearance)
                    }
                }
              }
              .offset(x: -offset(proxy))
            }
            .frame(width: proxy.size.width)
          })
          .frame(width: (proxy.size.width) / CGFloat(3))
          .mask { RoundedRectangle(cornerRadius: Constants.cornerRadius) }
          .offset(x: offset(proxy))
      }
    }
    .frame(alignment: .center)
  }

  func setAppearance(_ appearance: AppearanceManager.Appearance) {
    withAnimation(.easeInOut) {
      if appearance != appearanceManager.appearance {
        appearanceManager.appearance = appearance
      }
    }
  }
}
