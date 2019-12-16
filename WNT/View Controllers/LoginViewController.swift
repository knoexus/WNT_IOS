//
//  LoginViewController.swift
//  WNT
//
//  Created by AD on 07/12/2019.
//  Copyright © 2019 AD. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(loginButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil {
                let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    as? TabBarController

                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }

    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    as? TabBarController

                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
    
}
