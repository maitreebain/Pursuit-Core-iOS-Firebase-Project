//
//  SignInViewController.swift
//  Instagram-Proj
//
//  Created by Maitree Bain on 3/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var accountState = AccountState.existingUser
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            DispatchQueue.main.async {
                self.showAlert(title: "Missing Fields", message: "Please enter your e-mail/password")
            }
            return
        }
        
        //call email/pass func here
    }
    
    private func continueLogin(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { (result) in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error logging in", message: "\(error.localizedDescription)")
                    }
                case .success:
                    DispatchQueue.main.async {
                        //TODO: navigate to the main view
                        
                    }
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { (result) in
                
                switch result{
                case .failure(let error):
                    
                }
            }
        }
        
        
    }
    
}
