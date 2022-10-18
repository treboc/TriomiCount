//
//  TriomiCountApp.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI

@main
struct TriomiCountApp: App {
  @StateObject private var appearanceManager = AppearanceManager()
  private let context = CoreDataManager.shared.persistentContainer.viewContext
  @AppStorage("selectedAppearance") private var selectedAppearance: Int = 2

  var body: some Scene {
    WindowGroup {
      HomeTabView()
        .environment(\.managedObjectContext, context)
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
        .tint(.primaryAccentColor)
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
