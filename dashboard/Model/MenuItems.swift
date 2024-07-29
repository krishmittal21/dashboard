//
//  MenuItems.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

enum MenuItems: Int, CaseIterable {
    case documents = 0
    case projects
    case achievements
    case gallery
    
    var iconName: String {
        switch self {
        case .documents: return "doc"
        case .projects: return "triangle"
        case .achievements: return "trophy"
        case .gallery: return "camera"
        }
    }
    
    var label: String {
        switch self {
        case .documents: return "Documents"
        case .projects: return "Projects"
        case .achievements: return "Achievements"
        case .gallery: return "Gallery"
        }
    }
    
    var count: String? {
        switch self {
        case .documents: return nil
        case .projects: return "23"
        case .achievements: return "3"
        case .gallery: return nil
        }
    }
}
