//
//  MainView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = AuthenticationViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            DashboardView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
