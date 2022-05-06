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
  @StateObject private var appState = AppState()

  var body: some Scene {
    WindowGroup {
      HomeView()
        .id(appState.homeViewID)
        .environment(\.managedObjectContext, PersistentStore.shared.context)
        .environmentObject(appState)
        .environmentObject(appearanceManager)
        .onAppear {
          UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
          appearanceManager.setAppearance()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                   perform: handleResignActive)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification),
                   perform: handleBecomeActive)
    }
  }

  func handleResignActive(_ note: Notification) {
    // when going into background, save Core Data and shutdown timer
    PersistentStore.shared.saveContext(context: PersistentStore.shared.context)
    if PersistentStore.shared.context.hasChanges {
      do {
        try PersistentStore.shared.context.save()
      } catch let error as NSError {
        print("Error saving state on going to background \(error.localizedDescription)")
      }
    }
  }

  func handleBecomeActive(_ note: Notification) {
    // when app becomes active
  }
}
