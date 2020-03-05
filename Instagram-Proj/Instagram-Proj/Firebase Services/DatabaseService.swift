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
    
    public func createUserPost(imageURL: String, description: String, displayName: String, completion: @escaping (Result<String, Error>) -> ()) {
        
    }
}
