//
//  RegistrationViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 10/13/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func createAccount(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != nil, password != nil  else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if user != nil {
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let createStop = storyboard.instantiateViewController(identifier: "TravelListViewController") as! TravelListViewController
                    self.navigationController?.pushViewController(createStop, animated: true)
                    return
                    
                }
                
            }
        }
        
    }
    
}
