//
//  CheeseNavigationController.swift
//  DeliTest
//
//  Created by Zeev Gross on 04/11/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

class CheeseNavigationController: UINavigationController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         print ("segue -> \(segue.identifier)")
    }


}
