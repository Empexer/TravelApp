//
//  LoadingViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 10/22/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let remoteCinfig = RemoteConfig.remoteConfig()
        remoteCinfig.fetchAndActivate { (status, error) in
            DispatchQueue.main.async {
                self.showWelcome()
            }
            
            
        }
        
    }
    
    func showWelcome() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let firstVc = storyboard.instantiateViewController(identifier: "WelcomeController") as! WelcomeController
        self.navigationController?.pushViewController(firstVc, animated: true)
        
    }
}




