//
//  MenuView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct MenuView: View {
    @State private var selectedTab = 0
    @State private var isMenuOpen = false
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                TabContentView(selectedTab: $selectedTab, showProfile: $showProfile)
                if !showProfile {
                    MenuContentView(selectedTab: $selectedTab, isMenuOpen: $isMenuOpen)
                }
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    MenuView()
}
