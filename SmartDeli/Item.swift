//
//  Item.swift
//  DeliTest
//
//  Created by Zeev Gross on 26/06/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit
/*
struct produceKey{
    static let nameKey: String = "name"
    static let photoKey: String = "photo"
    static let quantityKey: String = "quantity"
    static let weightKey: String = "weight"
    static let commentKey: String = "comment"
    static let helpNeededKey: String = "helpNeeded"
}
*/
struct productItem  {
    
    // MARK: Properties
    
    var name: String = ""
    var photo: UIImage? = nil
    var quantity: String = ""
    var weight: String = ""
    var comment: String = ""
    var helpNeeded: Bool = false
    var orderNum: String = ""
}


/*
 class productItem :NSObject, NSCoding  {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var quantity: String
    var weight: String
    var comment: String
    var helpNeeded: Bool
   
 
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("produce")
    
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, quantity: String,weight: String, comment: String, helpNeeded: Bool) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.comment = comment
        self.quantity = quantity
        self.weight = weight
        self.helpNeeded = helpNeeded
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: produceKey.nameKey)
        aCoder.encodeObject(quantity, forKey: produceKey.quantityKey)
        aCoder.encodeObject(photo, forKey: produceKey.photoKey)
        aCoder.encodeObject(weight, forKey: produceKey.weightKey)
        aCoder.encodeObject(comment, forKey: produceKey.commentKey)
        aCoder.encodeObject(helpNeeded, forKey: produceKey.helpNeededKey)
   
    }
    

    required convenience init?(coder aDecoder: NSCoder) {
        
        let name        = aDecoder.decodeObjectForKey(produceKey.nameKey) as! String
        let photo       = aDecoder.decodeObjectForKey(produceKey.photoKey) as! UIImage
        let quantity    = aDecoder.decodeObjectForKey(produceKey.quantityKey) as! String
        let weight      = aDecoder.decodeObjectForKey(produceKey.weightKey) as! String
        let comment     = aDecoder.decodeObjectForKey(produceKey.commentKey) as! String
        let helpNeeded  = aDecoder.decodeObjectForKey(produceKey.helpNeededKey) as! Bool
        
        self.init(name: name, photo: photo, quantity: quantity, weight: weight, comment: comment, helpNeeded: helpNeeded)
    
    }

  
}
*/