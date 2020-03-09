//
//  ProfileViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

//optional vc
//pops up when people click on edit button
/*

 let profileView = ProfView()
 
 override func loadView() {
     view = profileView
 }
 */

class ProfileViewController: UIViewController {
    
    let profView = ProfView()
    
    override func loadView() {
        view = profView
    }
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profView.userName.delegate = self
        updateUI()
    }
    
    func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        profView.emailLabel.text = user.email
        profView.userName.text = user.displayName
        
        profView.userImage.kf.setImage(with: user.photoURL)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        profView.selectedImage = image
    }
}
