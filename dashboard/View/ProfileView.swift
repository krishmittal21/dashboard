//
//  ProfileView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI
import PhotosUI

enum ImagePickerType {
    case camera
    case photoLibrary
}

struct ProfileView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var tenantViewModel = TenantViewModel()
    @State private var showingDeleteConfirmation = false
    @State private var isEditing = false
    @State private var editableFirstName = ""
    @State private var editableLastName = ""
    @State private var editablePhone = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var avatarImage: UIImage?
    @State private var showingImagePicker = false
    @State private var imagePickerType: ImagePickerType = .photoLibrary
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .center) {
                            Group {
                                if let avatarImage = avatarImage {
                                    Image(uiImage: avatarImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else if let avatarURL = authenticationViewModel.user?.avatarURL, let url = URL(string: avatarURL) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "person")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    }
                                } else {
                                    Image(systemName: "person")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                            .shadow(radius: 20)
                            .onTapGesture {
                                showImageOptions()
                            }
                            
                            Text(authenticationViewModel.user?.fullName ?? "Firstname Lastname")
                                .customFont(.light, 20)
                            Text(authenticationViewModel.user?.phone ?? "1 (212) 222-2222")
                                .customFont(.light, 20)
                            
                            Button(action: {
                                isEditing = true
                                editableFirstName = authenticationViewModel.user?.firstName ?? ""
                                editableLastName = authenticationViewModel.user?.lastName ?? ""
                                editablePhone = authenticationViewModel.user?.phone ?? ""
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
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                    }
                    
                    ToolbarItem(placement: .principal)  {
                        Text("Profile")
                            .customFont(.light, 21)
                    }
                }
                .opacity(isEditing ? 0.3 : 1)
                .opacity(showingDeleteConfirmation ? 0 : 1)
                
                if showingDeleteConfirmation {
                    CustomDeleteAccountAlert(isPresented: $showingDeleteConfirmation) {
                        authenticationViewModel.delete()
                    }
                }
                
                if isEditing {
                    EditProfileView(
                        isEditing: $isEditing,
                        firstName: $editableFirstName,
                        lastName: $editableLastName,
                        phone: $editablePhone,
                        onSave: saveProfile
                    )
                }
            }
            .onAppear {
                authenticationViewModel.fetchUser()
            }
            .onChange(of: authenticationViewModel.user?.tenantId) {
                if let tenantId = authenticationViewModel.user?.tenantId {
                    tenantViewModel.fetchTenantName(for: tenantId)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $avatarImage, sourceType: imagePickerType == .camera ? .camera : .photoLibrary)
                    .ignoresSafeArea()
                    .onDisappear {
                        if let image = avatarImage {
                            authenticationViewModel.inputImage = image
                            authenticationViewModel.uploadProfilePhoto()
                        }
                    }
            }
        }
    }
    
    private func showImageOptions() {
        let alert = UIAlertController(title: "Change Profile Picture", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
            imagePickerType = .camera
            showingImagePicker = true
        })
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default) { _ in
            imagePickerType = .photoLibrary
            showingImagePicker = true
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func saveProfile() {
        Task {
            if await authenticationViewModel.updateUser(firstName: editableFirstName, lastName: editableLastName, phone: editablePhone) {
                isEditing = false
            } else {
                print("Failed to update profile: \(authenticationViewModel.errorMessage)")
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

#Preview {
    ProfileView()
}
