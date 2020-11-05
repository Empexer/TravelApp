//
//  WelcomeController .swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/24/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import FirebaseRemoteConfig


class WelcomeController: UIViewController {
    // MARK: - OUTLETS
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    //MARK:  - ACTIONS
    
    @IBAction func createAccount(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let createStop = storyboard.instantiateViewController(identifier: "RegistrationViewController") as! RegistrationViewController
        self.navigationController?.pushViewController(createStop, animated: true)
        
    }
    
    @IBAction func logInEmail(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let createStop = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(createStop, animated: true)
    }
    // MARK: - LIFECICLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let remoteConfig = RemoteConfig.remoteConfig()
        let loginTExt = remoteConfig["logInButtonText"].stringValue
        print("RemoteConfig:", loginTExt!)
        let isNeedToShowLogButton = remoteConfig["isNeedToShowLogInButton"].boolValue
        print("RemoteConfig:", isNeedToShowLogButton)
        logInButton.setTitle(loginTExt, for: .normal)
        if isNeedToShowLogButton == true {
            logInButton.isHidden = false
        }
        
    }
}
// MARK: - FUNCTIONS


func roundCorners(button: UIButton, radius: CGFloat) {
    button.layer.cornerRadius = radius
}




