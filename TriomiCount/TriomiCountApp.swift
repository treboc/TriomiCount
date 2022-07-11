//
//  TriomiCountApp.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

// @ObservedObject private var iO = Inject.observer

import SwiftUI

@main
struct TriomiCountApp: App {
  @StateObject private var appearanceManager = AppearanceManager()
  @AppStorage("selectedAppearance") private var selectedAppearance: Int = 2

  var body: some Scene {
    WindowGroup {
      HomeView()
        .environment(\.managedObjectContext, CoreDataManager.shared.context)
        .environmentObject(appearanceManager)
        .onAppear {
          UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
          appearanceManager.setAppearance()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                   perform: handleResignActive)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification),
                   perform: handleBecomeActive)
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
  }

  func handleResignActive(_ note: Notification) {
    // when going into background, save Core Data and shutdown timer
    CoreDataManager.shared.save()
  }

  func handleBecomeActive(_ note: Notification) {
    // when app becomes active
  }
}
