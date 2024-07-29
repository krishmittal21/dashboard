//
//  CustomDeleteAccountAlert.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct CustomDeleteAccountAlert: View {
    @Binding var isPresented: Bool
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                
                Text("Delete your account?")
                    .customFont(.bold, 20)
                
                Text("You will lose all of your data by deleting your account.")
                    .customFont(.light, 20)
                    .multilineTextAlignment(.center)
                
                Text("This includes all of your images and any other data on our servers.")
                    .customFont(.light, 20)
                    .multilineTextAlignment(.center)
                
                Text("This action cannot be undone")
                    .customFont(.light, 20)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                VStack(spacing: 10) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("No Do Not Delete and Go Back")
                            .customFont(.light, 18)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        onDelete()
                        isPresented = false
                    }) {
                        Text("Delete My Account")
                            .customFont(.medium, 16)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 40)
        }
    }
}
