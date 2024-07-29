//
//  MenuToggleButton.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct MenuToggleButton: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                isMenuOpen.toggle()
            }
        }) {
            Image(systemName: "square.3.layers.3d")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.primaryColor)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: -5)
                .offset(y: -5)
        }
    }
}
