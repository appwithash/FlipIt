//
//  LoadingView.swift
//  FlipIt
//
//  Created by ashutosh on 19/11/22.
//

import SwiftUI
struct ActivityIndicator: UIViewRepresentable {
  typealias UIView = UIActivityIndicatorView
  var isAnimating: Bool
  var configuration = { (_: UIView) in }

  func makeUIView(context _: UIViewRepresentableContext<Self>) -> UIView { UIView() }

  func updateUIView(_ uiView: UIView, context _: UIViewRepresentableContext<Self>) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    configuration(uiView)
  }
}

// swiftformat:disable all
extension View where Self == ActivityIndicator {
  func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self {
    Self(isAnimating: self.isAnimating, configuration: configuration)
  }
}

struct LoadingView<Content>: View where Content: View {
  @Environment(\.colorScheme) var colorScheme
  let isShow: Bool
  let animate: Bool
  var content: () -> Content
  var body: some View {
    ZStack {
      self.content()
        .disabled(isShow)
      if isShow {
        Color.primary.opacity(0.5)
          .colorScheme(colorScheme == .dark ? .light : .dark)
          .animation(.default)
        self.overlay
          .animation(.default)
      }
    }
  }
//    loadingGif
  var overlay: some View {
    VStack {
      Text("Loading...")
            .foregroundColor(self.colorScheme == .dark ? .white : .black)
        .font(.headline)
      ActivityIndicator(isAnimating: true, configuration: {
        $0.hidesWhenStopped = true
        $0.style = .medium
      })
       
    }
    .padding(20)
    .background(self.colorScheme == .dark ? Color.black.grayscale(0.8) : Color.white.grayscale(0.8))
    .cornerRadius(20)
    .shadow(radius: 3)
  }
}
