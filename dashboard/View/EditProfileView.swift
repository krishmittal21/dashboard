//
//  EditProfileView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var isEditing: Bool
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    
    var onSave: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
            
            HStack {
                Button("Cancel") {
                    isEditing = false
                }
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    onSave()
                }
                .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}
