//
//  StorageService.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/9/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    private let storageRef = Storage.storage().reference()
    
    public func uploadImage(userID: String? = nil, postID: String? = nil, image: UIImage, completion: @escaping (Result<URL,Error>) -> () ) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        
        var photoReference: StorageReference!
        
        if let userID = userID {
            photoReference = storageRef.child("UserProfilePhotos/\(userID).jpg")
        } else if let postID = postID {
            photoReference = storageRef.child("PostPhotos/\(postID).jpg")
        }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        let _ = photoReference.putData(imageData, metadata: metaData) { (metadata, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                photoReference.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                    
                }
            }
        }
        
    }
    
}
