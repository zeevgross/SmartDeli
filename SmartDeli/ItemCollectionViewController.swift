//
//  ItemCollectionViewController.swift
//  DeliTest
//
//  Created by Zeev Gross on 29/06/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

var store = storeInventory(name: "Rishon", id: 123)

class ItemCollectionViewController : UICollectionViewController {
    
    
    var tableData: [String] = ["T-Bone", "Gound Beef", "Fillet","Osso Bucco"]
    var tableImages: [String] = ["tbone", "ground", "fillet", "osobucco"]
    var inventoryTable = [inventory]()
//  var store = storeInventory(name: "Rishon", id: 123)
    var deliName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beefInventoryLoad()
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inventoryTable.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ItemCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCollectionViewCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        cell.itemName.text      = inventoryTable[indexPath.row].name
        cell.itemImage.image    = inventoryTable[indexPath.row].photo
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
    }
 
    // MARK: - Navigation
    
    /// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var item = productItem()
        
        if segue.identifier == "newItemView" {
            let newItemDetailView = segue.destinationViewController as! NewItemDetailView
            
            if let selectedItemlCell = sender as? ItemCollectionViewCell {
                let indexPath = collectionView!.indexPathForCell(selectedItemlCell)!
                item.photo  = inventoryTable[indexPath.row].photo
                item.name = inventoryTable[indexPath.row].name
                newItemDetailView.item = item
            }
            print ("newItemView")
        }
    }
    

    func getDeliInventory(name: String) -> [inventoryItem]
    {
        for i in 0..<store!.deli.count{
            if store!.deli[i].deliName == name
            {
                return store!.deli[i].Items
            }
        }
        return store!.deli[0].Items
    }
    

    func beefInventoryLoad() {
        
        // load inventory data
    
        let myDeli  = getDeliInventory(deliName)
        let maxID = myDeli.count
        
        for id in 0..<maxID{
            let  item = inventory(itemId: id+1, name : myDeli[id].name, photo: myDeli[id].photo)
            inventoryTable.append(item!)
       }
        
    }

}