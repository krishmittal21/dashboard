//
//  LoginView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

@MainActor
struct LoginView: View {
    @State private var viewModel = AuthenticationViewModel()
    @State private var isSignupView = false
    
    private func signInWithEmailPassword() {
        Task {
            await viewModel.signInWithEmailPassword()
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .customFont(.bold, 28)
                
                Text("Some small message which appears\nwhen people were away")
                    .customFont(.regular, 16)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                VStack(spacing: 15) {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: {}) {
                    Text("Forgotten Password?")
                        .customFont(.regular, 14)
                        .foregroundColor(.gray)
                }
                
                Button(action: signInWithEmailPassword) {
                    if viewModel.authenticationState != .authenticating {
                        Text("Login")
                            .customFont(.medium, 16)
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(.label))
                            .cornerRadius(8)
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.systemBackground)))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(.label))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Don't have an account?")
                        .customFont(.regular, 16)
                    
                    Text("Sign Up")
                        .customFont(.light, 16)
                        .foregroundColor(Color.primaryColor)
                        .onTapGesture {
                            isSignupView.toggle()
                        }
                }
                .padding(.bottom, 60)
                
                Image(systemName: "faceid")
                    .font(.system(size: 40))
                
                Button(action: {}) {
                    Text("Enabled Face ID")
                        .customFont(.medium, 16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.primaryColor)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isSignupView) {
                SignupView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    LoginView()
}
