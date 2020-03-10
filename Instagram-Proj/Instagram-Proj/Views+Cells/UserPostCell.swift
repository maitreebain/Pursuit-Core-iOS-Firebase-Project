//
//  UserPostCell.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/10/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import Kingfisher

class UserPostCell: UICollectionViewCell {
    
    @IBOutlet weak var userPostImage: UIImageView!
    
    public func configureCell(for post: PostModel) {
        
        userPostImage.kf.setImage(with: URL(string: post.imageURL))
    }
}
