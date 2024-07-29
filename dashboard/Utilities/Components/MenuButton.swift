//
//  MenuButton.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct MenuButton: View {
    let item: MenuItems
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.primaryAccentColor)
                        .frame(width: 40, height: 40)
                }
                
                VStack {
                    Image(systemName: item.iconName)
                        .foregroundColor(.white)
                    if let count = item.count {
                        Text(count)
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .frame(width: 60, height: 60)
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
