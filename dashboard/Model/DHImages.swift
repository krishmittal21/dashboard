//
//  DHImages.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

class DHImages: ObservableObject, Identifiable, Equatable {
    let id: String = UUID().uuidString
    let name: String
    @Published var image: UIImage
    let dateCreated: Date
    let sessionId: String
    
    init(name: String, dateCreated: Date, sessionId: String) {
        self.name = name
        self.image = UIImage(systemName: "photo")!
        self.dateCreated = dateCreated
        self.sessionId = sessionId
        
        FirebaseStorageHelper.asyncDownloadToFileSystem(relativePath: "images/\(self.name).jpeg") { fileUrl in
            do {
                let imageData = try Data(contentsOf: fileUrl)
                self.image = UIImage(data: imageData) ?? self.image
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static func == (lhs: DHImages, rhs: DHImages) -> Bool {
        return lhs.id == rhs.id
    }
}
