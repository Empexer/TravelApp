//
//  WelcomeViewController.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/24/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
     //экран был загружен. Верстки еще нет! 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidLoad")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidDisappear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
}
 
