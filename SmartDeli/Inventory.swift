//
//  Inventory.swift
//  DeliTest
//
//  Created by Zeev Gross on 18/09/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit


class storeInventory : NSObject
    {
    var storeName: String = ""
    var storeId: Int = 0
    var deli =  [deliInventory]()
    var photoCache = [PhotoItem]()
    var cacheUpdated: Bool = false
    
    init?(name: String, id: Int){
        
        super.init()
        
        // Load any saved meals, otherwise load sample data.
        if let savedPhotos = loadPhotos() {
            photoCache += savedPhotos
        }
        else {
            
            // Load the sample data.
           print ("Cache empty")
        }

        loadDeliItems()
        
        if cacheUpdated {
            savePhotos()
        }
    
        if name.isEmpty {
            return nil
        }
    }
    
    //let json = try? NSJSONSerialization.JSONObjectWithData(asset!.data, options: NSJSONReadingOptions.AllowFragments)
    
  
    func loadDeliItems()
    {
        
        var tmpDeli: deliInventory
        
        //if let path = NSBundle.mainBundle().pathForResource("assets/inventory", ofType: "json") {
        if let asset = NSDataAsset(name: "inventory", bundle: NSBundle.mainBundle()){
            do {
                
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(asset.data, options: []) as? [String:AnyObject]
                {
                    guard let store = jsonResult["store"] as? [String:AnyObject]
                        else{
                            return
                    }
                    
                    guard let delies = store["delies"] as? [AnyObject]
                        else{
                            return
                    }
                    
                    for i in 0..<delies.count
                    {
                        let tmpName = (delies[i]["deliName"] as? String)!
                        let tmpId:Int = (delies[i]["deliId"] as? Int)!
                     
                        tmpDeli = deliInventory(name: tmpName, id: tmpId)!
                        
                        
                        guard let items = delies[i]["items"] as? [AnyObject]
                            else{
                                return
                        }
                        for j in 0..<items.count
                        {
                            
                            
                            let tmpItemId:Int = (items[j]["itemId"] as? Int)!
                            let tmpItemName = (items[j]["itemName"] as? String)!
                            let tmpPhotoName = (items[j]["itemPhoto"] as? String)!
                            let tmpPhoto = loadPhoto(tmpPhotoName)
                            
                            let item = inventoryItem(itemId: tmpItemId,name:  tmpItemName, photo: tmpPhoto)!
                            tmpDeli.Items.append(item)
                        }
                        deli.append(tmpDeli)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    


    func getPhoto (deli: String, item: String) -> UIImage?{
        
        for i in 0..<self.deli.count{
            if self.deli[i].deliName == deli {
                
                for j in 0..<self.deli[i].Items.count {
                    
                    if self.deli[i].Items[j].name == item{
                        return  self.deli[i].Items[j].photo!
                    }
                }
            }
        }
        return nil
    }
    
    func getItemId (deli: String, item: String) -> Int{
        
        for i in 0..<self.deli.count{
            if self.deli[i].deliName == deli {
                
                for j in 0..<self.deli[i].Items.count {
                    
                    if self.deli[i].Items[j].name == item{
                        return  self.deli[i].Items[j].itemId
                    }
                }
            }
        }
        return 0
    }
    
    func loadPhoto(name: String) -> UIImage{
     
        let baseUrl = "http://192.168.1.149/images/"
        let myUrl: String = baseUrl + name + ".jpg"
        let url = NSURL(string: myUrl)
     
        // Search in photo cache
        
        for i in 0..<photoCache.count{
            if photoCache[i].name == name{
                return photoCache[i].photo!
            }
        }
        
        
        //load from network
        guard let imageData = NSData(contentsOfURL: url!)
        else{
            print ("\(name) is missing")
            return UIImage(named: "placeholder")!
        }
        
        //update photo cache
        
        let photo = UIImage(data:imageData)!
        let newPhoto = PhotoItem( name: name, photo: photo)
        photoCache.append (newPhoto!)
        print ("photo chack updated with \(name)")
        cacheUpdated = true
        return photo
        
    }
    
    
    // MARK: NSCoding
    
    func savePhotos() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(photoCache, toFile: PhotoItem.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save Photos...")
        }
    }
    
    func loadPhotos() -> [PhotoItem]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(PhotoItem.ArchiveURL.path!) as? [PhotoItem]
        
    }
    
}

class deliInventory: NSObject  {
    
    var deliName: String
    var deliId: Int
    var Items =  [inventoryItem]()
    
    init?(name: String, id: Int){
        
        self.deliId = id
        self.deliName = name

        super.init()
        
        // Initialization should fail if there is no deli name
        
        if name.isEmpty {
            return nil
        }
    }
    
    
}

class inventoryItem: NSObject  {
    
    // MARK: Properties
    
    var itemId: Int
    var name: String
    var photo: UIImage?
    
    // MARK: Initialization
    
    init?(itemId: Int,name: String, photo: UIImage?){
        
        // Initialize stored properties.
        self.itemId = itemId
        self.name = name
        self.photo = photo
        
        super.init()
        
        // Initialization should fail if there is no deli name
        if name.isEmpty {
            return nil
        }
    }
}


class inventory: NSObject  {
    
             
        // MARK: Properties
        
        var itemId: Int32
        var name: String
        var photo: UIImage?
        
        // MARK: Initialization
        
        init?(itemId: Int32,name: String, photo: UIImage?){
            
            // Initialize stored properties.
            self.itemId = itemId
            self.name = name
            self.photo = photo
            
            super.init()
            
            // Initialization should fail if there is no deli name
            if name.isEmpty {
                return nil
            }
        }
}