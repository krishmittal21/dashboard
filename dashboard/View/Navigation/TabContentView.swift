//
//  TabContentView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct TabContentView: View {
    @Binding var selectedTab: Int
    @Binding var showProfile: Bool

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(showProfile: $showProfile)
                .tag(0)
            TaskView()
                .tag(1)
            AchievementView()
                .tag(2)
            GalleryView()
                .tag(3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
