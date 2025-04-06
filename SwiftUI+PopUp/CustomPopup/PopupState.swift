//
//  PopupState.swift
//  Shared
//
//  Created by ejsong on 3/27/25.
//
import SwiftUI
import ComposableArchitecture

struct PopupState<Action>: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String?
    var message: String?
    var cancelAction: PopupButtonState<Action>?
    var confirmAction: PopupButtonState<Action>?
    
    init(title: String? = nil, message: String? = nil, cancelAction: PopupButtonState<Action>?, confirmAction: PopupButtonState<Action>?) {
        self.title = title
        self.message = message
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
    
    init() { }
}

public struct PopupButtonState<Action>: Identifiable, Equatable {
    public static func == (lhs: PopupButtonState<Action>, rhs: PopupButtonState<Action>) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id: UUID
    public let action: Action
    public let title: String
    
    public init(action: Action, title: String) {
        self.id = UUID()
        self.action = action
        self.title = title
    }
}
