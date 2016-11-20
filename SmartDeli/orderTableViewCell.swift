//
//  orderTableViewCell.swift
//  DeliTest
//
//  Created by Zeev Gross on 30/10/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

class orderTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    /*
    @IBOutlet weak var itemPhoto: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemComment: UILabel!
    */
    
    
    @IBOutlet weak var deliName: UILabel!
    @IBOutlet weak var estimatedTimeToService: UILabel!
    @IBOutlet weak var progrssBar: UIProgressView!
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   /* override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }*/
    
}
