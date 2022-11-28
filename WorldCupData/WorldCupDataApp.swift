//
//  WorldCupDataApp.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 24/11/22.
//

import SwiftUI
import ComposableArchitecture

@main
struct WorldCupDataApp: App {
    var storeWrapper: WrappedStruct<Store<WorldCupFeature.State, WorldCupFeature.Action>> = WrappedStruct(withItem: Store(
        initialState: WorldCupFeature.State(),
        reducer: WorldCupFeature()
    ))
    
    var body: some Scene {
        WindowGroup {
            WithViewStore(self.storeWrapper.item, observe: { $0 }) { viewStore in
                NavigationView {
                    if viewStore.token == "" {
                        LoginView()
                    } else {
                        MainView()
                    }
                }
                .environmentObject(storeWrapper)
            }
        }
    }
}
