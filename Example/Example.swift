//
//  Example.swift
//  ResizableTextFieldSwiftUI
//
//  Created by Daniel Eze on 2023-05-01.
//

import SwiftUI

struct Example: View {
    @State private var text: String = ""
    @State private var isActive: Bool = true // this means the text field is active
    @State private var textFieldHeight: CGFloat = 50

    var body: some View {
        textField
            .padding()
    }

    private var textField: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(lineWidth: 1, antialiased: true)
                .frame(height: textFieldHeight + 2)

            HStack {
                ResizableTextField(text: $text, isActive: $isActive, height: $textFieldHeight, maxHeight: 100)
                    .frame(height: textFieldHeight)
                    .padding(.horizontal)

                Button {
                    // this removes the keyboard from the screen
                    isActive = false
                    text = ""

                } label: {
                    Text("Send")
                        .padding(.trailing)
                }
            }
        }
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}
