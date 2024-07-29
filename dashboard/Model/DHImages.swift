//
//  DHImages.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import SwiftUI

class DHImages: ObservableObject, Identifiable {
    var id:String = UUID().uuidString
    var name: String
    @Published var image: UIImage
    var dateCreated: TimeInterval
    var sessionId: String
    
    init(name: String, dateCreated: TimeInterval, sessionId: String) {
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
}
