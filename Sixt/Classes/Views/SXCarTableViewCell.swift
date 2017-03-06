//
//  SXCarTableViewCell.swift
//  Sixt
//
//  Created by Shahrukh on 23/12/2016.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class SXCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var fuelLevelLabel: UILabel!
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var cleanlinessLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
