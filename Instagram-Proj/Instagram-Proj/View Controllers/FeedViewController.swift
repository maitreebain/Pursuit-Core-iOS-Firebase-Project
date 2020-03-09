//
//  FeedViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/4/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedView = FeedView()
    
    //listener here
    
    override func loadView() {
        view = feedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedView.collectionView.delegate = self
        feedView.collectionView.dataSource = self
        feedView.collectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "feedCell")
    }

}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let interItemSpacing: CGFloat = 10
            let maxWidth = UIScreen.main.bounds.size.width
            let numberOfItems: CGFloat = 1
            let totalSpacing: CGFloat = numberOfItems * interItemSpacing
            let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
            
            return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath)
        
        cell.backgroundColor = .yellow
        return cell
    }
}
