//
//  MenuContentView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct MenuContentView: View {
    @Binding var selectedTab: Int
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if isMenuOpen {
                ForEach(MenuItems.allCases, id: \.self) { item in
                    MenuButton(item: item, isSelected: selectedTab == item.rawValue) {
                        selectedTab = item.rawValue
                    }
                    .padding(.bottom, item == .documents ? 50 : 0)
                }
            }
            
            MenuToggleButton(isMenuOpen: $isMenuOpen)
        }
        .background(Color.primaryColor)
        .cornerRadius(10)
        .shadow(radius: 5)
        .animation(.spring(), value: isMenuOpen)
        .padding()
    }
}
