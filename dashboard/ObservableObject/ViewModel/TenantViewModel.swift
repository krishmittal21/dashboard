//
//  TenantViewModel.swift
//  dashboard
//
//  Created by Krish Mittal on 29/07/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class TenantViewModel: ObservableObject {
    @Published var tenantName: String = ""
    
    func fetchTenantName(for tenantId: String) {
        let db = Firestore.firestore()
        db.collection("tenant").document(tenantId).getDocument { (document, error) in
            if let document = document, document.exists {
                if let name = document.data()?["name"] as? String {
                    DispatchQueue.main.async {
                        self.tenantName = name
                    }
                }
            } else {
                print("Tenant document does not exist")
            }
        }
    }
}
