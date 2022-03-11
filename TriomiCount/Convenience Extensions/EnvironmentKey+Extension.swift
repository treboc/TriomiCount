//
//  EnvironmentKey+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 09.02.22.
//

import SwiftUI

struct RootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var rootPresentation: Binding<Bool> {
        get { self[RootPresentationKey.self] }
        set { self[RootPresentationKey.self] = newValue }
    }
}
