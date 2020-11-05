//
//  StopCell.swift
//  T-app TRAINING
//
//  Created by Zakhar Sidorov  on 9/3/20.
//  Copyright © 2020 Zakhar Sidorov . All rights reserved.
//

import UIKit
import SwipeCellKit

class StopCell: SwipeTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spendMoney: UILabel!
    
    @IBOutlet weak var descriptionOfStop: UILabel!
    
    @IBOutlet weak var viewOnCell: UIView!
    @IBOutlet weak var rateStack: UIStackView!
    
    @IBOutlet weak var transportImage: UIImageView!
    

    override func awakeFromNib() {
        viewOnCell.layer.cornerRadius = 10
      
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    func stopToTravel(name: String, description: String) {
  
        

}
}
