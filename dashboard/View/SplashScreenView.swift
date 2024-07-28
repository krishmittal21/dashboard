//
//  SplashScreenView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        ZStack {
            if self.isActive {
                DashboardView()
            } else {
                ZStack(alignment: .top) {
                    Color(hex: "#ECECEC").ignoresSafeArea()
                    
                    VStack(alignment: .center, spacing: 20) {
                        Text("Welcome \(authenticationViewModel.user?.firstName ?? "[userFirstName]")")
                            .customFont(.light, 25)
                        
                        Text("This is your first time using Argus.\nLet us explain what we will do\nand what happens afterwards.")
                            .customFont(.light, 18)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(3.0)
                    .padding()
                    .padding(.bottom, 200)
                }
//                .overlay(
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Image(systemName: "square.3.layers.3d.top.filled")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(.purple)
//                                .padding()
//                                .background(Color.white)
//                                .clipShape(Circle())
//                                .shadow(radius: 5)
//                        }
//                    }
//                    .padding()
//                )
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
