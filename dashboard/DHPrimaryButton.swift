//
//  DHPrimaryButton.swift
//  dashboard
//
//  Created by Krish Mittal on 28/07/24.
//

import SwiftUI

struct DHPrimaryButton: View {
    let title: String
    let action: () -> Void
    let isLoading: Bool
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.systemBackground)))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
            } else {
                Text(title)
                    .customFont(.medium, 16)
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
            }
        }
        .background(Color(.label))
        .cornerRadius(8)
    }
}
