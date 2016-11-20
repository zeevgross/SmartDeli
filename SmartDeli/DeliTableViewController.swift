//
//  DeliTableViewController.swift
//  DeliTest
//
//  Created by Zeev Gross on 03/11/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

class DeliTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    @IBOutlet weak var itemPhoto: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemComment: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
