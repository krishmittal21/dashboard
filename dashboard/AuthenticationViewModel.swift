//
//  AuthenticationViewModel.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import Foundation
import Observation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationError: Error {
    case tokenError(message: String)
}

@Observable @MainActor class AuthenticationViewModel {
    var firstName = ""
    var lastName = ""
    var email = ""
    var phone = ""
    var password = ""
    var confirmPassword = ""
    var authenticationState: AuthenticationState = .unauthenticated
    var isValid: Bool  = false
    var errorMessage: String = ""
    var currentUserId: String = ""
    var user: DHUser? = nil
    var displayName = ""
    var privacyChecked: Bool = false
    
    private var handler: AuthStateDidChangeListenerHandle?
    private var userListener: ListenerRegistration?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
}

extension AuthenticationViewModel {
    
    func signInWithEmailPassword() async -> Bool {
        do {
            let result = try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            firstName = result.user.displayName ?? ""
            email = result.user.email ?? ""
            return true
        }
        catch  {
            print(error)
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func signUpWithEmailPassword() async -> Bool {
        
        authenticationState = .authenticating
        
        guard validate() else {
            return false
        }
        
        do  {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            do {
                try await result.user.sendEmailVerification()
                print("Verification email sent successfully!")
            } catch {
                print("Error sending verification email: \(error.localizedDescription)")
            }
            insertUserRecord(id: currentUserId)
            
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func passwordReset(){
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func fetchUser(){
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        let db = Firestore.firestore()
        userListener = db.collection(DHUserModelName.userFirestore).document(userId).addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let data = documentSnapshot?.data() else {
                print("No user data found")
                return
            }
            DispatchQueue.main.async {
                self.user = DHUser(
                    id: data[DHUserModelName.id] as? String ?? "",
                    tenantId: data[DHUserModelName.tenantId] as? String ?? "",
                    role: data[DHUserModelName.role] as? String ?? "",
                    email: data[DHUserModelName.email] as? String ?? "",
                    firstName: data[DHUserModelName.firstName] as? String ?? "",
                    lastName: data[DHUserModelName.lastName] as? String ?? "",
                    phone: data[DHUserModelName.phone] as? String ?? "",
                    avatarURL: data[DHUserModelName.avatarURL] as? String,
                    joined: data[DHUserModelName.joined] as? TimeInterval ?? Date().timeIntervalSince1970,
                    lastUpdated: data[DHUserModelName.lastUpdated] as? TimeInterval ?? Date().timeIntervalSince1970,
                    createdBy: data[DHUserModelName.createdBy] as? String ?? "",
                    editedBy: data[DHUserModelName.editedBy] as? String ?? "",
                    status: data[DHUserModelName.status] as? String ?? "",
                    sysState: data[DHUserModelName.sysState] as? String ?? ""
                )
            }
        }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        
        guard privacyChecked == true else {
            errorMessage = "Please Check the Privacy Policy First !"
            return false
        }
        
        guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
              !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@(gmail|yahoo|outlook|icloud)\.(com|net|org|edu)$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            errorMessage = "Please enter a valid email address from Google, Yahoo, Outlook, or iCloud."
            return false
        }
        
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        guard passwordPredicate.evaluate(with: password) else {
            errorMessage = "Password must be at least 8 characters long and contain at least one letter and one number."
            return false
        }
        
        guard password == confirmPassword else{
            errorMessage = "Passwords Dont Match"
            return false
        }
        
        return true
    }
}

extension AuthenticationViewModel {
    private func insertUserRecord(id: String) {
        let now = Date().timeIntervalSince1970
        
        let newUser = DHUser(
            id: id,
            tenantId: "default", // Default tenant ID
            role: "user", // Default role
            email: email,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            avatarURL: nil, // Set to nil initially
            joined: now,
            lastUpdated: now,
            createdBy: id,
            editedBy: id,
            status: "active", // Set an initial status
            sysState: "open" // Set an initial system state
        )
        
        let db = Firestore.firestore()
        
        db.collection(DHUserModelName.userFirestore)
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    public var isSignedIn: Bool{
        return Auth.auth().currentUser != nil
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func delete() {
        Auth.auth().currentUser?.delete()
    }
}
