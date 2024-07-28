//
//  DHUser.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import Foundation

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
