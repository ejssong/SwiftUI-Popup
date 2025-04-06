//
//  MainFeature.swift
//  SwiftUI+PopUp
//
//  Created by Eunjin Song on 4/6/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PopupFeature {
    
    struct State: Equatable {
        @PresentationState var popup: PopupState<Popup>? = nil
    }
    
    @CasePathable
    public enum Popup: Equatable {
        case didTapCancel
        case didTapConfirm
    }
}

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State : Equatable {
        var popState: PopupFeature.State = .init()
    }
    
    @CasePathable
    enum Action {
        case view(ViewAction)
        case popup(PresentationAction<PopupFeature.Popup>)
        
        @CasePathable
        public enum ViewAction {
            case didTapPopup
        }
    }
    
    var body: some ReducerOf<Self> {
        CombineReducers {
            ViewReducer
            PopupReducer
        }
        .ifLet(\.popState.$popup, action: \.popup) { }
    }
    
    private var ViewReducer: some Reducer<State, Action> {
        Reduce { state, action in
            guard case let .view(viewAction) = action else { return .none }
            
            switch viewAction {
            case .didTapPopup:
                state.popState.popup = .init(title: "팝업 입니다.",
                                            message: "팝업 메세지 입니다.",
                                            cancelAction: .init(action: .didTapCancel, title: "취소"),
                                            confirmAction: .init(action: .didTapConfirm, title: "확인"))
                return .none
            }
        }
    }
    
    
    private var PopupReducer: some Reducer<State, Action> {
        Reduce { state , action in
        
            guard case let .popup(.presented(dialogAction)) = action else { return .none }
            
            switch dialogAction {
            case .didTapCancel:
                print("didTapCancel")
                return .none
            case .didTapConfirm:
                print("didTapConfirm")
                return .none
                
            }
        }
    }
}
