//
//  TabViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var feedViewController: FeedViewController = {
        let viewController = FeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "photo.on.rectangle"), tag: 0)
        return viewController
    }()
    
    private lazy var imagePostViewController: ImagePostViewController = {
        let viewController = ImagePostViewController()
        viewController.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera.circle.fill"), tag: 1)
        return viewController
    }()
    
    private lazy var userViewController: UserViewController = {
        let storyboard = UIStoryboard(name: "UserView", bundle: nil)
        guard let viewController =  storyboard.instantiateViewController(identifier: "UserViewController") as? UserViewController else { return UserViewController()}
        viewController.tabBarItem = UITabBarItem(title: "Account Posts", image: UIImage(systemName: "photo.fill"), tag: 2)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        
        viewControllers = [
            UINavigationController(rootViewController: feedViewController),
            UINavigationController(rootViewController: imagePostViewController),
            UINavigationController(rootViewController: userViewController)
        ]
    }
    


}
