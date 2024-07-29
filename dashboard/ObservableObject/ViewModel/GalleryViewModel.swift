//
//  GalleryViewModel.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import Foundation
import FirebaseFirestore

class GalleryViewModel: ObservableObject {
    @Published var images: [DHImages] = []
    
    private let db = Firestore.firestore()
    
    func fetchData(){
        db.collection("images").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            self.images = documents.map {(queryDocumentSnapshot) -> DHImages in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let dateCreated = data["dateCreated"] as? TimeInterval ?? 0
                let sessionId = data["sessionId"] as? String ?? ""
                return DHImages(name: name, dateCreated: dateCreated, sessionId: sessionId)
            }
        }
    }
    
    
}
