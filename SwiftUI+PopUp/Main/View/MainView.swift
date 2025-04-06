//
//  MainView.swift
//  SwiftUI+PopUp
//
//  Created by Eunjin Song on 4/6/25.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    var body: some View{
        ZStack {
            Color(cgColor: CGColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1))
            VStack {
                Button {
                    store.send(.view(.didTapPopup))
                } label: {
                    Text("팝업 오픈")
                }
            }
            .popup(store: store.scope(state: \.popState.$popup, action: \.popup))
        }
    }
}

#Preview {
    MainView(store: Store(initialState: MainFeature.State(), reducer: { MainFeature() }))
}
