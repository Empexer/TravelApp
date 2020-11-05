//
//  ForgotPasswordViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 10/21/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var textFieldEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        if let email = textFieldEmail.text {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil {
                    self.showAlert()
                }
                if error != nil {
                    print(error)
                }
                
            }
            
        }
    }
    func showAlert() {
        let alert = UIAlertController.init(title: "Check your email, please", message: nil , preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
}
