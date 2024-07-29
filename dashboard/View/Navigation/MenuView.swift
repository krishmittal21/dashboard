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
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabContentView(selectedTab: $selectedTab)
            MenuContentView(selectedTab: $selectedTab, isMenuOpen: $isMenuOpen)
        }
    }
}

#Preview {
    MenuView()
}
