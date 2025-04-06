//
//  CustomPopupView.swift
//  Shared
//
//  Created by ejsong on 3/27/25.
//

import SwiftUI
import ComposableArchitecture
/**
 State : 커스텀 팝업 내 띄워질 상태를 PopupState<Action>으로 관리
 Action :  (PopupButtonState<Action>) -> Void 을 받아 액션 정의
 */
struct CustomPopupView<ContentView, Action>: View where ContentView: View {
    
    @Binding var isPresented: Bool
    let state: PopupState<Action>?
    let action: (PopupButtonState<Action>) -> Void
    let contentView: () -> ContentView
    
    public var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 8) {
                Text(state?.title ?? "타이틀 입니다.")
                    .foregroundStyle(.black)
                
                Text(state?.message ?? "메세지 입니다.")
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 16)
            
            HStack(spacing: 6) {
                Button {
                    if let cancel = state?.cancelAction {
                        action(cancel)
                    }
                } label: {
                    Text(state?.cancelAction?.title ?? "취소")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundStyle(.gray)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 56)
                .background(Color(cgColor: CGColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)))
                
                Button {
                    if let confirmAction = state?.confirmAction {
                        action(confirmAction)
                    }
                } label: {
                    Text(state?.confirmAction?.title ?? "확인")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundStyle(.white)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 56)
                .background(.blue)
            }
        }
        .padding(.all, 12)
        .frame(width: 300)
        .background(.white)
    }
}
