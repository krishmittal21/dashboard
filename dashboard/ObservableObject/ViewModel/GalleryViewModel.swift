//
//  GalleryViewModel.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import Foundation
import FirebaseFirestore

class GalleryViewModel: ObservableObject {
    @Published var imageGroups: [String: [DHImages]] = [:]
    
    private let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("images").order(by: "dateCreated", descending: true).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            let images = documents.compactMap { queryDocumentSnapshot -> DHImages? in
                let data = queryDocumentSnapshot.data()
                guard let name = data["name"] as? String,
                      let dateCreated = (data["dateCreated"] as? Timestamp)?.dateValue(),
                      let sessionId = data["sessionId"] as? String else {
                    return nil
                }
                return DHImages(name: name, dateCreated: dateCreated, sessionId: sessionId)
            }
            
            self.imageGroups = Dictionary(grouping: images, by: { $0.sessionId })
        }
    }
}
