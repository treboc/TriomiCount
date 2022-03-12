//
//  AppState.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 15.02.22.
//

import Combine

class AppState: ObservableObject {
    @Published var gameOnboardingIsShown: Bool = false
}
