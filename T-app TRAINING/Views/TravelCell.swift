//
//  TravelCell.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 8/27/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import SwipeCellKit
class TravelCell: SwipeTableViewCell {
  //MARK: - OUTLETS
    
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet weak var viewOnCell: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewOnCell?.layer.cornerRadius = 10
    
    }



}

