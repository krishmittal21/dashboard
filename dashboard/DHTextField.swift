//
//  DHTextField.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct DHTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .textFieldStyle(PlainTextFieldStyle())
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
    }
}
