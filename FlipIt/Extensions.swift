//
//  Extensions.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI


extension View {
    func hideKeyboardOnTap() -> some View {
      modifier(HideKeyboardOnTapModifier())
    }

    func showLoader(_ show: Bool, animate: Bool = true) -> some View {
      LoadingView(isShow: show, animate: animate) {
        self
      }
    }
}


struct HideKeyboardOnTapModifier: ViewModifier {
  @State private var isKeyboardVisible = false

  func body(content: Content) -> some View {
    content.overlay(isKeyboardVisible ?
                      Color.white.opacity(0.001).onTapGesture(perform: resignResponder) : nil
    )
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)) { _ in
      self.isKeyboardVisible = true
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)) { _ in
      self.isKeyboardVisible = false
    }
  }

  func resignResponder() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
