//
//  DHUser.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import Foundation

struct DHUserModelName {
    static let id = "id"
    static let tenantId = "tenantId"
    static let role = "role"
    static let email = "email"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let phone = "phone"
    static let avatarURL = "avatarURL"
    static let joined = "joined"
    static let lastUpdated = "lastUpdated"
    static let createdBy = "createdBy"
    static let editedBy = "editedBy"
    static let status = "status"
    static let sysState = "sysState"
    static let fullName = "fullName"

    // Firestore collection name
    static let userFirestore = "users"
}

struct DHUser: Encodable, Hashable, Identifiable {
    let id: String
    let tenantId: String
    var role: String
    var email: String
    var firstName: String
    var lastName: String
    var phone: String
    var avatarURL: String?
    let joined: TimeInterval
    var lastUpdated: TimeInterval
    let createdBy: String
    var editedBy: String
    var status: String
    var sysState: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
