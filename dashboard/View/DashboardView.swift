//
//  DashboardView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @State private var showProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Dashboard")
                        .customFont(.light, 25)
                    
                    Spacer()
                    
                    Image(systemName: "person")
                        .onTapGesture {
                            showProfile.toggle()
                        }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Tenant")
                            .customFont(.medium, 10)
                        Text(authenticationViewModel.user?.tenantId ?? "Default")
                            .customFont(.light, 10)
                    }
                    
                    HStack {
                        Text("Status")
                            .customFont(.medium, 10)
                        Text(authenticationViewModel.user?.status ?? "Default")
                            .customFont(.light, 10)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear(perform: {
                authenticationViewModel.fetchUser()
            })
            .navigationDestination(isPresented: $showProfile) {
                ProfileView().toolbarRole(.editor)
            }
        }
    }
}

#Preview {
    DashboardView()
}
