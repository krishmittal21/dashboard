//
//  InfoRow.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .customFont(.light, 18)
                Spacer()
                Text(value)
                    .customFont(.light, 18)
            }
            .padding()
            
            Divider()
        }
    }
}
