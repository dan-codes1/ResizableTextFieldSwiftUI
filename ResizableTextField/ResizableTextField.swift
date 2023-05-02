//
//  ResizableTextField.swift
//  ResizableTextFieldSwiftUI
//
//  Created by Daniel Eze on 2023-05-01.
//

import SwiftUI

struct ResizableTextField {
    var text: Binding<String>
    var isActive: Binding<Bool>? // determines whether or not to show the keyboard.
    var height: Binding<CGFloat>

    var maxHeight: CGFloat
    var font: Font

    init(text: Binding<String>, height: Binding<CGFloat>, maxHeight: CGFloat = .greatestFiniteMagnitude, font: Font = .body) {
        self.text = text
        self.isActive = nil
        self.height = height
        self.maxHeight = maxHeight
        self.font = font
    }

    init(text: Binding<String>, isActive: Binding<Bool>, height: Binding<CGFloat>, maxHeight: CGFloat = .greatestFiniteMagnitude, font: Font = .body) {
        self.text = text
        self.isActive = isActive
        self.height = height
        self.maxHeight = maxHeight
        self.font = font
    }
}

extension ResizableTextField {

    private func textView() -> UITextView {
        let textView = UITextView()
        textView.text = text.wrappedValue
        textView.font = .font(from: font)
        return textView
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var view: ResizableTextField

        init(_ view: ResizableTextField) {
            self.view = view
        }

        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async { [weak self] in
                self?.view.text.wrappedValue = textView.text
            }
        }

    }
}

extension ResizableTextField: UIViewRepresentable {

    func makeUIView(context: Context) -> UITextView {
        let textView = textView()
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            uiView.text = text.wrappedValue
            height.wrappedValue = min(maxHeight, uiView.contentSize.height)

            if let isFocused = isActive {
                if isFocused.wrappedValue == false {
                    uiView.resignFirstResponder()
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct ResizableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ResizableTextField(text: .constant("sample text"), isActive: .constant(true), height: .constant(50), maxHeight: 100, font: .body)
    }
}
