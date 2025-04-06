//
//  PopupView+.swift
//  Shared
//
//  Created by ejsong on 3/28/25.
//
@_spi(Presentation)
import ComposableArchitecture
import SwiftUI

/**
 Presentation 메서드 내 Body는 클로저인데 뷰를 그리기 위해서 3가지를 받아온다.
 1. Content
 → 기존 뷰 (Self)
 2. isPresented
 →  PresentationState<State> 은 내부적으로 State를 옵셔널로 감싸고 있어 팝업을 열고 닫고 하는 트리거 역활을 한다.
 3. destination
 → 실제로 띄워질 뷰 ( 커스텀 팝업)
 */

extension View {

    func popup<Action, Content>(
        store: Store<PresentationState<PopupState<Action>>, PresentationAction<Action>>,
        @ViewBuilder content: @escaping (String?) -> Content = { _ in EmptyView() }
    ) -> some View where Content: View {
        popup(store: store, state: { $0 }, action: { $0 }, content: content)
    }

    private func popup<State, Action, ButtonAction, Content>(
        store: Store<PresentationState<State>, PresentationAction<Action>>,
        state toDestinationState: @escaping (State) -> PopupState<ButtonAction>?,
        action fromDestinationAction: @escaping (ButtonAction) -> Action,
        @ViewBuilder content: @escaping (String?) -> Content
    ) -> some View where Content: View {
        
        presentation(store: store, state: toDestinationState, action: fromDestinationAction) { `self`, $isPresented, destination in
            let dialogState = store.withState { $0.wrappedValue.flatMap(toDestinationState)}
            let dialogContent: () -> Content = {
                content(dialogState?.id)
            }
            self.modifier(PopupModifer(isPresented: $isPresented,
                                       presenting: dialogState,
                                       content: { state in
                CustomPopupView<Content, ButtonAction>.init(
                    isPresented: $isPresented,
                    state: state,
                    action: { (buttonState) in
                        store.send(.presented(fromDestinationAction(buttonState.action)))
                        store.send(.dismiss)
                    }, contentView: dialogContent)
            }))
        }
    }
}
