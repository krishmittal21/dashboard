//
//  DashboardView.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var tenantViewModel = TenantViewModel()
    @State private var showProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
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
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Tenant")
                                .customFont(.medium, 10)
                            Text(tenantViewModel.tenantName)
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
                .onChange(of: authenticationViewModel.user?.tenantId) {
                    if let tenantId = authenticationViewModel.user?.tenantId {
                        tenantViewModel.fetchTenantName(for: tenantId)
                    }
                }
                .navigationDestination(isPresented: $showProfile) {
                    ProfileView().toolbarRole(.editor)
            }
            }
        }
    }
}

#Preview {
    DashboardView()
}
