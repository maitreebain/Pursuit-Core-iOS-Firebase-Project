//
//  DatabaseService.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/5/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DatabaseService {
    
    static let userPost = "userPost"
    
    private let db = Firestore.firestore()
    
    public func createUserPost(description: String, displayName: String, completion: @escaping (Result<String, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        let documentRef = db.collection(DatabaseService.userPost).document()
        
        db.collection(DatabaseService.userPost).document(documentRef.documentID).setData([
        "description": description,
        "date": Timestamp(date: Date()),
        "userName": displayName,
        "userID": user.uid
        ]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(documentRef.documentID))
            }
        }
    }
}
