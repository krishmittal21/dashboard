//
//  GalleryView.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                galleryContent(in: geometry)
            }
            galleryContent(in: geometry)
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
    
    @ViewBuilder
    func galleryContent(in geometry: GeometryProxy) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 10) {
                    Text("Gallery")
                        .customFont(.light, 25)
                    VStack {
                        Image(systemName: "photo")
                        Spacer()
                        Text("")
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    Image(systemName: "square.grid.2x2")
                    Image(systemName: "calendar")
                }
                .padding(.horizontal)
                
                ForEach(Array(viewModel.imageGroups.keys.sorted(by: >)), id: \.self) { sessionId in
                    if let images = viewModel.imageGroups[sessionId] {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(relativeDate(for: images[0].dateCreated))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(formattedDate(for: images[0].dateCreated))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: geometry.size.width / 2 - 20)
                            
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(images) { image in
                                    Image(uiImage: image.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: (geometry.size.width / 2 - 20) / 2, height: (geometry.size.width / 2 - 20) / 2)
                                        .clipped()
                                        .cornerRadius(5)
                                        .id(image.id)
                                }
                            }
                            .frame(width: geometry.size.width / 2 - 20)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .padding(.vertical)
        }
        .frame(width: geometry.size.width / 2)
    }
    
    func relativeDate(for date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: date)
    }
}

#Preview {
    GalleryView()
}
