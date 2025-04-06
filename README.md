# SwiftUI-Popup
커스텀 팝업

### ❗️ 문제점
>SwiftUI 에서 팝업을 띄우는 방법으론 여러가지가 있다
>
> 1. .fullScreenCover 
> 2. .alert 
> 3. .sheet
> 4. Overlay , ZStack 활용 
> 5. …
>
> 위 방법 들은 모두 Binding 값을 State에 가지고 있어야 한다. 
> 하지만 하나의 뷰에서 여러 팝업을 띄워야 한다면, 모든 팝업의 상태값을 가지고 관리해야 한다.

### ✨ 해결 방안
> TCA에서 제공하는 Alert 을 참고해 커스텀 팝업을 재구성 하였습니다. 

## 1. PopupState.Swift
<img width="900" alt="Screenshot 2025-04-06 at 4 43 11 PM" src="https://github.com/user-attachments/assets/e1296b26-668b-4b5d-a5bb-0ea1fed81444" />

```Swift
struct PopupState<Action>: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String?
    var message: String?
    var cancelAction: PopupButtonState<Action>?
    var confirmAction: PopupButtonState<Action>?
    
    init(title: String? = nil, message: String? = nil, 
		    cancelAction: PopupButtonState<Action>?, 
		    confirmAction: PopupButtonState<Action>?) {
        self.title = title
        self.message = message
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
}
```

## 2. PopupView+.swift
<img width="900" alt="Screenshot 2025-04-06 at 4 41 05 PM" src="https://github.com/user-attachments/assets/a72a2136-7c94-4e39-a0d1-8fe6225e9b6b" />

```Swift
extension View {
    func popup<Action, Content>(
        store: Store<PresentationState<PopupState<Action>>, 
        PresentationAction<Action>>,
        @ViewBuilder content: @escaping (String?) -> Content 
        = { _ in EmptyView() }
    ) -> some View where Content: View {
        popup(store: store, state: { $0 }, 
			        action: { $0 }, content: content)
    }
    
    private func popup<State, Action, ButtonAction, Content>(...) {
    
    }
  } 
```

## 3. TCA 내 Presentation 분석
<img width="900" alt="Screenshot 2025-04-06 at 4 57 32 PM" src="https://github.com/user-attachments/assets/c98e242e-5db0-40e4-8659-43a8b07478da" />

> Presentation 내 Body는 클로저인데 뷰를 그리기 위해서 3가지를 받아온다.
> 1. Content 
> → 기존 뷰 (Self) 
> 2. isPresented
> →  PresentationState<State> 은 내부적으로 State를 옵셔널로 감싸고 있어 팝업을 열고 닫고 하는 트리거 역활을 한다. 
> 3. destination 
> → 실제로 띄워질 뷰 ( 커스텀 팝업) 

### 🌸 사용 방법
```Swift
struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    var body: some View{
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
```
