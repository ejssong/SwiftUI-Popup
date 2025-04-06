//
//  PopupModifer.swift
//  Shared
//
//  Created by ejsong on 3/28/25.
//
import SwiftUI
import ComposableArchitecture

//struct VisualEffect: UIViewRepresentable {
//    @State var style : UIBlurEffect.Style
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        return UIVisualEffectView(effect: UIBlurEffect(style: style))
//    }
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//    }
//}

struct PopupModifer<ContentView, Action>: ViewModifier where ContentView: View{
    @Binding var isPresented: Bool
     let presenting: PopupState<Action>?
     let content: (PopupState<Action>) -> ContentView

     func body(content: Content) -> some View {
         content
             .overlay(
                Group {
                    if isPresented, let presenting = presenting {
                        self.content(presenting).transition(.scale)
                    }
                }
             )
     }
}
