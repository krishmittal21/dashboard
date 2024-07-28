//
//  SplashScreenView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                DashboardView()
            } else {
                Color.primaryColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image(systemName: "app.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Text("App Name")
                        .customFont(.bold, 28)
                        .foregroundColor(.white)
                }
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
