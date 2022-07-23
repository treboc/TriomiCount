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
          Text(title(appearence))
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
        }
      }
      .overlay(alignment: .leading) {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.accentColor)
          .overlay(alignment: .leading, content: {
            GeometryReader { _ in
              HStack(spacing: 0) {
                ForEach(AppearanceManager.Appearance.allCases, id: \.self) { appearance in
                  Text(appearance.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.label)
                    .onTapGesture {
                      withAnimation(.easeInOut) {
                        appearanceManager.appearance = appearance
                      }
                    }
                }
              }
              .offset(x: -offset(proxy))
            }
            .frame(width: proxy.size.width)
          })
          .frame(width: (proxy.size.width) / CGFloat(3))
          .mask { RoundedRectangle(cornerRadius: 4) }
          .offset(x: offset(proxy))
      }
    }
  }
}
