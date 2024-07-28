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
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
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
}
