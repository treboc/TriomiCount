//
//  TriomiCountApp.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI

@main
struct TriomiCountApp: App {
  @AppStorage("selectedAppearance") private var selectedAppearance: Int = 2
  @StateObject private var appState = AppState()

  var body: some Scene {
    WindowGroup {
      HomeView()
        .id(appState.homeViewID)
        .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
        .environment(\.managedObjectContext, PersistentStore.shared.context)
        .environmentObject(appState)
        .onAppear {
          UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: handleResignActive)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: handleBecomeActive)
    }
  }

  func handleResignActive(_ note: Notification) {
    // when going into background, save Core Data and shutdown timer
    PersistentStore.shared.saveContext(context: PersistentStore.shared.context)
    if PersistentStore.shared.childViewContext().hasChanges {
      do {
        try PersistentStore.shared.childViewContext().save()
        print("saved!")
      } catch let error as NSError {
        print("Error saving state on going to background \(error.localizedDescription)")
      }
    }
  }

  func handleBecomeActive(_ note: Notification) {
    // when app becomes active
  }
}
