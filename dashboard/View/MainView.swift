//
//  MainView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @AppStorage("first_user") var firstTimeUser: Bool = true
    
    var body: some View {
        Group {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                if firstTimeUser {
                    SplashScreenView()
                        .onDisappear {
                            firstTimeUser = false
                        }
                } else {
                    DashboardView()
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
