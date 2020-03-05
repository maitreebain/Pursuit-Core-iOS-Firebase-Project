//
//  ProfileView.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    public lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.fill")
        return iv
    }()
    
    public lazy var updateProfButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Update Profile"
        return button
    }()
    
    public lazy var userName: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter a display name"
        return text
    }()
    
    public lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail:"
        return label
    }()
    
    public lazy var bioText: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    public lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Sign Out"
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpUserImageConstraints()
        setUpUserNameConstraints()
    }
    
    private func setUpUserImageConstraints() {
        addSubview(userImage)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpUserNameConstraints() {
        addSubview(userName)
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            userName.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
