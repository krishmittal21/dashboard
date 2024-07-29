//
//  ProfileView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var tenantViewModel = TenantViewModel()
    @State private var showingDeleteConfirmation = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .center) {
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Rectangle())
                                .shadow(radius: 20)
                            
                            Text(authenticationViewModel.user?.fullName ?? "Firstname Lastname")
                                .customFont(.light, 20)
                            Text(authenticationViewModel.user?.phone ?? "1 (212) 222-2222")
                                .customFont(.light, 20)
                            
                            Button(action: {
                                // Edit profile
                            }) {
                                HStack {
                                    Image(systemName: "pencil")
                                    Text("Edit Profile")
                                        .customFont(.light, 16)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            }
                            .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Overview")
                                    .customFont(.light, 18)
                                Spacer()
                                Text("")
                            }
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            
                            Group {
                                InfoRow(title: "Account", value: authenticationViewModel.user?.id ?? "0018 1994 1293 1841")
                                InfoRow(title: "Created On", value: formatDate(authenticationViewModel.user?.joined))
                                InfoRow(title: "Role", value: authenticationViewModel.user?.role ?? "SUPER_ADMIN")
                                InfoRow(title: "Tenant Name", value: tenantViewModel.tenantName)
                            }
                        }
                        .padding(.bottom, 50)
                        
                        Button(action: {
                            showingDeleteConfirmation = true
                        }) {
                            HStack {
                                Text("Delete Account")
                                    .customFont(.light, 18)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .bold()
                            }
                        }
                        .padding()
                        .background(Color.white)
                    }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                    }
                }
                .alert(isPresented: $showingDeleteConfirmation) {
                    Alert(
                        title: Text("Delete your account?"),
                        message: Text("You will lose all of your data by deleting your account. This includes all of your images and any other data on our servers. This action cannot be undone."),
                        primaryButton: .destructive(Text("Delete My Account")) {
                            authenticationViewModel.delete()
                        },
                        secondaryButton: .cancel(Text("No Do Not Delete and Go Back"))
                    )
                }
                .onAppear {
                    authenticationViewModel.fetchUser()
                }
                .onChange(of: authenticationViewModel.user?.tenantId) {
                    if let tenantId = authenticationViewModel.user?.tenantId {
                        tenantViewModel.fetchTenantName(for: tenantId)
                    }
                }
            }
        }
    }
    
    private func formatDate(_ timeInterval: TimeInterval?) -> String {
        guard let timeInterval = timeInterval else { return "N/A" }
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d'th' yyyy"
        return formatter.string(from: date)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .customFont(.light, 18)
                Spacer()
                Text(value)
                    .customFont(.light, 18)
            }
            .padding()
            
            Divider()
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
