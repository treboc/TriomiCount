//
//  GameResultsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 28.02.22.
//

import SwiftUI

struct GameResultsView: View {
  @EnvironmentObject var vm: GameViewModel
  @EnvironmentObject var appstate: AppState
  
  var body: some View {
    ZStack {
      Color("SecondaryBackground")
        .ignoresSafeArea()
      
      VStack {
        Text("Game Results")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .padding(.bottom, 50)
        
        HStack {
          Text("Name")
            .font(.title2)
          
          Spacer()
          
          Text("Points")
        }
        .padding(.horizontal, 30)
        
        Divider()
        
        ForEach(vm.game.playersArray) { player in
          HStack {
            Text(player.name)
              .font(.title2)
            
            Spacer()
            
            Text("\(player.currentScore) Pts.")
          }
        }
        .padding(.horizontal, 30)
        .padding([.bottom, .top], 15)
        
        Spacer()
        
        Button("Main menu") {
          NavigationUtil.popToRootView()
        }
      }
      Spacer()
    }
    .padding(.vertical, 30)
  }
  
  
}


//struct GameResultsView_Previews: PreviewProvider {
//    static let vm = GameViewModel(Player.allPlayers())
//
//    static var previews: some View {
//        Group {
//            GameResultsView()
//                .environmentObject(vm)
//                .preferredColorScheme(.dark)
//            GameResultsView()
//        }
//    }
//}
