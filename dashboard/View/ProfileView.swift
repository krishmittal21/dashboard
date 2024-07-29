//
//  ProfileView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
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
    ProfileView()
}
