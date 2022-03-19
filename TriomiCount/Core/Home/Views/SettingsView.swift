//
//  SettingsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 27.01.22.
//

import SwiftUI

struct SettingsView: View {
  //  @Binding var isDarkMode: Bool
  @Binding var selectedAppearance: Int
  @Environment(\.dismiss) var dismiss

  var body: some View {
    NavigationView {
      Form {
        Picker("Select theme", selection: $selectedAppearance) {
          HStack {
            Text("Light")
            Spacer()
            if selectedAppearance == 1 {
              Image(systemName: "checkmark")
            }
          }
          .contentShape(Rectangle())
          //        .onTapGesture { isDarkMode = false }
          .onTapGesture { selectedAppearance = 1 }

          HStack {
            Text("Dark")
            Spacer()
            if selectedAppearance == 2 {
              Image(systemName: "checkmark")
            }                }
          .contentShape(Rectangle())
          //        .onTapGesture { isDarkMode = true }
          .onTapGesture { selectedAppearance = 2 }

          HStack {
            Text("System")
            Spacer()
            if selectedAppearance == 0 {
              Image(systemName: "checkmark")
            }                }
          .contentShape(Rectangle())
          //        .onTapGesture { isDarkMode = true }
          .onTapGesture {
              selectedAppearance = 0
          }
        }

        //      Section("Theme".uppercased()) {
        //        HStack {
        //          Text("Light")
        //          Spacer()
        //          if selectedAppearance == 1 {
        //            Image(systemName: "checkmark")
        //          }
        //        }
        //        .contentShape(Rectangle())
        //        //        .onTapGesture { isDarkMode = false }
        //        .onTapGesture { selectedAppearance = 1 }
        //
        //        HStack {
        //          Text("Dark")
        //          Spacer()
        //          if selectedAppearance == 2 {
        //            Image(systemName: "checkmark")
        //          }                }
        //        .contentShape(Rectangle())
        //        //        .onTapGesture { isDarkMode = true }
        //        .onTapGesture { selectedAppearance = 2 }
        //
        //        HStack {
        //          Text("System")
        //          Spacer()
        //          if selectedAppearance == 0 {
        //            Image(systemName: "checkmark")
        //          }                }
        //        .contentShape(Rectangle())
        //        //        .onTapGesture { isDarkMode = true }
        //        .onTapGesture {
        //          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        //            selectedAppearance = 0
        //          }
        //        }
        //      }

        Section("Rules") {
          VStack(alignment: .leading) {
            Text("Beginning").font(.headline)
              .padding(.bottom, 10)
            Text("""
                        Zu Beginn des Spiels liegen alle Steine mit der Oberseite nach unten auf dem Tisch und werden gemischt. Die Spieler ziehen ihre jeweiligen Steine zufällig. Die Anzahl der Steine, die jeder Spieler zieht, hängt von der Anzahl der Mitspieler ab: bei 2 Spielern zieht jeder 9 Steine, bei 4 z. B. nur 7. Einer der Spieler notiert für alle ständig die erzielten Punkte. Der Spieler mit dem höchsten Tripelstein (einem Stein mit 3 gleichen Zahlen) beginnt das Spiel, indem er diesen Stein ablegt. Dafür bekommt er 10 Punkte plus die Summe der Zahlen des Steins. Ausnahme: wenn als Tripelstein der Nullerstein (also der mit 3 Nullen) gelegt wird, so bekommt der Spieler, der ihn ablegt, 40 Punkte gut geschrieben. Sollte kein Spieler einen Tripelstein legen können oder wollen, so beginnt der Spieler mit dem höchsten Stein, d. h. mit dem Stein, der die höchste Zahlsumme besitzt. Wenn zwei oder mehr Spieler gleich hohe Steine besitzen, dann beginnt der Spieler mit dem nächsthöheren Einzelstein. Der Spieler, der ihn ablegt, bekommt allerdings nur die Summe des Steins gutgeschrieben.
                        """)
          }
        }
      }
      .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
    }
  }
}

//struct SettingsPopoverView_Previews: PreviewProvider {
//  static var previews: some View {
//    SettingsView(isDarkMode: .constant(true))
//  }
//}
