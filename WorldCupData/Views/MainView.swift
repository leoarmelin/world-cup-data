//
//  ContentView.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 24/11/22.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @EnvironmentObject var storeWrapper: WrappedStruct<Store<WorldCupFeature.State, WorldCupFeature.Action>>
    
    var body: some View {
        WithViewStore(storeWrapper.item, observe: {$0}) { viewStore in
            TabView {
                TeamListView()
                    .tabItem{
                        Text("Teams")
                    }
                    .toolbar(.visible, for: .tabBar)
                    .toolbarBackground(Color(cgColor: CGColor(red: 255, green: 223, blue: 0, alpha: 1)), for: .tabBar)
                    .onAppear {
                        viewStore.send(.getTeamsList)
                    }
                
                MatchesListView()
                    .tabItem {
                        Text("Matches")
                    }
                    .toolbar(.visible, for: .tabBar)
                    .toolbarBackground(Color.red, for: .tabBar)
                    .onAppear {
                        viewStore.send(.getMatchesList)
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
