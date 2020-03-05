//
//  UserModel.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/5/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

struct PostModel {
    let imageURL: String
    let date: Date
    let description: String
    let userName: String
    let userID: String
}

extension PostModel {
    init(_ dictionary: [String: Any]){
        self.imageURL = dictionary["imageURL"] as? String ?? "no image found"
        self.date = dictionary["date"] as? Date ?? Date()
        self.description = dictionary["description"] as? String ?? "no description"
        self.userName = dictionary["userName"] as? String ?? "no user name found"
        self.userID = dictionary["userID"] as? String ?? "no userID found"
    }
}
