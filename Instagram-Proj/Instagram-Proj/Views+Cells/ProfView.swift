//
//  ProfileView.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfView: UIView {
    
    private let storageService = StorageService()
    
    public lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.fill")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    public lazy var updateProfButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Profile", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    
    public lazy var userName: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter a display name"
        text.textAlignment = .center
        text.backgroundColor = .white
        text.layer.cornerRadius = 10
        return text
    }()
    
    public lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail:"
        return label
    }()
    
    public lazy var bioText: UITextView = {
        let tv = UITextView()
        tv.text = "bio"
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    public lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    public var selectedImage: UIImage? {
        didSet{
            userImage.image = selectedImage
        }
    }
    
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
        setUpUpdateButtonConstraints()
        setUpEmailLabelConstraints()
        setUpBioTextConstraints()
        setUpSignOutButtonConstraints()
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
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 8),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userName.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setUpUpdateButtonConstraints() {
        addSubview(updateProfButton)
        
        updateProfButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            updateProfButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            updateProfButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            updateProfButton.heightAnchor.constraint(equalToConstant: 44),
            updateProfButton.widthAnchor.constraint(equalToConstant: 120),
            updateProfButton.centerXAnchor.constraint(equalTo: userName.centerXAnchor)
        ])
    }
    
    private func setUpEmailLabelConstraints() {
        addSubview(emailLabel)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func setUpBioTextConstraints() {
        addSubview(bioText)
        
        bioText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bioText.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 60),
            bioText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bioText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bioText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpSignOutButtonConstraints() {
        addSubview(signOutButton)
        
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: bioText.bottomAnchor, constant: 20),
            signOutButton.widthAnchor.constraint(equalToConstant: 120),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

}
