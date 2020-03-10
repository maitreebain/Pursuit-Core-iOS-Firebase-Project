//
//  FeedCell.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/10/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var userPostImage: UIImageView!
    @IBOutlet weak var userPostDescript: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    public func configureCell(for post: PostModel) {
        userPostImage.kf.setImage(with: URL(string: post.imageURL))
        
        userPostDescript.text = "\(post.description)"
        
        userName.text = "@\(post.userName)"
    }
}
