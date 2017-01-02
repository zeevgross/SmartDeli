//
//  ImageBank.swift
//  SmartDeli
//
//  Created by Zeev Gross on 22/11/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//


import UIKit

struct PropertyKey {
    static let nameKey = "name"
    static let photoKey = "photo"
    static let timeToLivekey = "ttl"
}

class PhotoItem: NSObject, NSCoding  {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var ttl: Int
    
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("PhotoBank")
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.ttl = 5 

        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty  {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(ttl, forKey: PropertyKey.timeToLivekey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        
        // Must call designated initializer.
        self.init(name: name, photo: photo)
    }
    
}
