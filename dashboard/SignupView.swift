//
//  SignupView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Create a New Account")
                    .customFont(.bold, 28)
                
                Text("Create an account so you can start using\nthe application after approval")
                    .customFont(.regular, 16)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                VStack(spacing: 15) {
                    DHTextField(placeholder: "First name", text: $viewModel.firstName)
                    DHTextField(placeholder: "Last Name", text: $viewModel.lastName)
                    DHTextField(placeholder: "Email", text: $viewModel.email)
                    DHTextField(placeholder: "Mobile Number", text: $viewModel.phone)
                    DHTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                    DHTextField(placeholder: "Repeat Password", text: $viewModel.confirmPassword, isSecure: true)
                }
                
                HStack {
                    Checkbox(isChecked: $viewModel.privacyChecked)
                    
                    Text("I agree to the ")
                        .customFont(.regular, 14)
                    + Text("Terms of Service")
                        .customFont(.regular, 14)
                        .foregroundColor(Color.primaryColor)
                    + Text(" and ")
                        .customFont(.regular, 14)
                    + Text("Privacy Policy")
                        .customFont(.regular, 14)
                        .foregroundColor(Color.primaryColor)
                    + Text(" and ")
                        .customFont(.regular, 14)
                    + Text("Data Use")
                        .customFont(.regular, 14)
                        .foregroundColor(Color.primaryColor)
                }
                .padding(.vertical)
                
                DHPrimaryButton(title: "Sign Up", action: signUp, isLoading: viewModel.authenticationState == .authenticating)
                
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.primaryColor)
                    Text("Already have an account? ")
                        .customFont(.regular, 16)
                    Text("Sign In")
                        .customFont(.light, 16)
                        .foregroundColor(Color.primaryColor)
                }
                .onTapGesture {
                    dismiss()
                }
            }
            .padding()
        }
        .alert("Verification Email Sent", isPresented: .constant(viewModel.isEmailVerificationSent)) {
            Button("OK") {
                viewModel.isEmailVerificationSent = false
                dismiss()
            }
        } message: {
            Text("Please check your email and verify your account before logging in.")
        }
        .alert(isPresented: .constant(!viewModel.errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")) {
                viewModel.errorMessage = ""
            })
        }
    }
    
    private func signUp() {
        Task {
            await viewModel.signUpWithEmailPassword()
        }
    }
}

struct Checkbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? Color.primaryColor : .gray)
                .imageScale(.large)
        }
    }
}

#Preview {
    SignupView()
}
