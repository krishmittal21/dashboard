//
//  DashboardView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

@MainActor
struct DashboardView: View {
    @State private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        HStack {
            Image(systemName: "rectangle.portrait.and.arrow.right")
            Text("Sign out")
        }
        .foregroundStyle(.red)
        .onTapGesture {
            authenticationViewModel.signOut()
        }
    }
}

#Preview {
    DashboardView()
}
