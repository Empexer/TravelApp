//
//  UIViewController+EX.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 9/28/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit

extension UIViewController {
    class func fromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
