//
//  SwiftUI_PopUpApp.swift
//  SwiftUI+PopUp
//
//  Created by Eunjin Song on 4/6/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct SwiftUI_PopUpApp: App {
    private let mainStore: StoreOf<MainFeature>
    
    init() {
        self.mainStore = Store(initialState: MainFeature.State(), reducer: { MainFeature() })
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(store: mainStore)
        }
    }
}
