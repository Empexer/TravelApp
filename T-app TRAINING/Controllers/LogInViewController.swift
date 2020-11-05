//
//  LogInViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/24/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    //MARK:  - OUTLETS
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var AuthLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgetPasswordLabel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.alpha = 0
        
    }
    
    //MARK:  - ACTIONS
    @IBAction func forgotPasswordButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let forgotVC = storyboard.instantiateViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotVC, animated: true)
        
        
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email.isEmpty == false, password.isEmpty == false  else {
            warningAnimation(text: "Info is't current")
            //ВОРНИНГ!
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.warningAnimation(text: "Error")
                
                
                return
            }
            if user != nil {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let createStop = storyboard.instantiateViewController(identifier: "TravelListViewController") as! TravelListViewController
                self.navigationController?.pushViewController(createStop, animated: true)
                return
                
            }
            self.warningAnimation(text: "There is no such user")
            
            
        }
        
    }
    
    // MARK: FUNCTIONS 
    
    
    func roundCorners(button: UIButton, radius: CGFloat) {
        button.layer.cornerRadius = radius
    }
    
    func warningAnimation(text: String) {
        warningLabel.text = text
        UIView.animate(withDuration: 1, animations: {
            self.warningLabel.alpha = 1
        }) { complete  in
            UIView.animate(withDuration: 1, animations: {
                self.warningLabel.alpha = 0
            }) 
        }
    }
}

