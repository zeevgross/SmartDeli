//
//  order.swift
//  DeliTest
//
//  Created by Zeev Gross on 18/09/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

//import Foundation
import UIKit

struct orderData
{
    var deliName: String
    var orderNum: String
    var estimedTime: String
    var startTime: String
    
    init()
    {
        deliName = ""
        orderNum = ""
        estimedTime = ""
        startTime = ""
    }
}


class DeliOrder: NSObject  {
    
    // MARK: Properties
    
    var deliName: String
    var items = [productItem] ()

    
    // MARK: Initialization
    
    init?(deliName: String) {
        // Initialize stored properties.
        self.deliName = deliName
        
        super.init()
   
        // Initialization should fail if there is no deli name
        if deliName.isEmpty {
            return nil
        }
    }
 
}

class CustomerOrder :NSObject  {
    
    // MARK: Properties
    
    var customerMail: String
    var storeName: String
    var deliOrders = [DeliOrder]()
    var orderTracking = [orderData] ()
    var storeId: Int

    var newOrder = [String]()
    var index: Int
    
    // MARK: Initialization
    
    init?(mail: String, store: String) {
        // Initialize stored properties.
        self.customerMail = mail
        self.storeName = store
        self.storeId = 555
        self.index = 0
        super.init()
        
        // Initialization should fail if there is no email address
        if mail.isEmpty {
            return nil
        }
        buildDelies()
        
    }
    
    func buildDelies(){
        
        let deliNames = ["Beef","Cheese","Fish","Poultry"]
        var deli:DeliOrder
        
        let size = deliNames.count
        
        for i in 0..<size
        {
            deli = DeliOrder(deliName: deliNames[i])!
            deliOrders.append(deli)
        }
        
    }
    
    func getItemsArray (name: String) -> [productItem]{
        
        for i in 0..<deliOrders.count {
            if deliOrders[i].deliName == name{
                return deliOrders[i].items
            }
        }
        return []
    }
    
    func getItemsArrayIndex (name: String) -> Int{
        
        for i in 0..<deliOrders.count {
            if deliOrders[i].deliName == name{
                return i
            }
        }
        return 0
    }
    
    func getItemsCount (name: String) -> Int{
        
        for i in 0..<deliOrders.count {
            if deliOrders[i].deliName == name{
                return deliOrders[i].items.count
            }
        }
        return 0
    }

    func appendItem(deliName :String, item: productItem){
        
        let myTmp = item
        for i in 0..<deliOrders.count {
            if deliOrders[i].deliName == deliName{
                    deliOrders[i].items.append(myTmp)
            }
        }
    }
   
    
    func checkCustomer( mail: String) -> Bool
    {
        if customerMail == mail
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func checkStore( storeId: String) -> Bool
    {
        if store == storeId
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func calcProgress(order: DeliOrder){
    
    
    
        
    }
    
    func deliName2Id (name: String) -> Int
    {
        
        var id:Int
        
        switch name{
            case  "Beef"    : id=1
            case  "Cheese"  : id=2
            case  "Fish"    : id=3
            case  "Poultry" : id=4
        default:
            id = 0
        }
        return id
    }
    
    func deliId2Name (deli: Int) -> String
    {
        var deliName: String = ""
        
        switch deli{
            case 1: deliName = "Beef"
            case 2: deliName = "Cheese"
            case 3: deliName = "Fish"
            case 4: deliName = "Poultry"

        default:
            deliName = ""
        }
        return deliName
    }
    
     /*
     **  import order status in JSON format for all delies
     */

    func getOrderFromServer ()
    {
        var found: Bool = false
        var orderId: String = ""
        var newItem: Bool = false
        var tmpDeliResponse =  orderData()
        var tmpItem =  productItem()
        var  tmpDeliName: String = ""
        
        let orderSemaphore = dispatch_semaphore_create(0)
        
        let url = NSURL(string: "http://192.168.1.103:8080/api/v1/orders?customer=1&served=0")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [AnyObject]
                {
                    let orderCount = jsonResult.count
                    for idx in 0..<orderCount{
                        guard let order = jsonResult[idx] as? [String:AnyObject]
                            else{
                                return
                        }
                        
                        let orderIdint = (order["orderId"] as? Int)!
                        orderId = String(orderIdint)
                        
                        guard let deli = order["deli"] as? [String:AnyObject]
                            else{
                                return
                        }
                        let deliId = (deli["deliId"] as? Int)!
                        tmpDeliName = self.deliId2Name(deliId)
                        newItem = false
                        for j in 0..<self.orderTracking.count{
                            
                            if (self.orderTracking[j].orderNum == orderId){
                                found = true
                                print ("updated")
                                
                                self.orderTracking[j].estimedTime = (order["eta"] as? String)!
                                self.orderTracking[j].startTime = (order["created"] as? String)!
                                self.updateNewOrder(orderId)
                                newItem = false
                            }
                        
                        }
                        if found == false{
                            tmpDeliResponse.orderNum = orderId
                            tmpDeliResponse.deliName = tmpDeliName
                            tmpDeliResponse.estimedTime = (order["eta"] as? String)!
                            tmpDeliResponse.startTime = (order["created"] as? String)!
                            self.orderTracking.append(tmpDeliResponse)
                            self.updateNewOrder(orderId)
                            newItem = true
                        
                        }
                        
                        found = false
                        
                        // Process order Items
                        
                        if newItem{
                        
                            guard let items = order["OrderItem"] as? [AnyObject]
                                else{
                                    return
                            }
                            for j in 0..<items.count
                            {
                                guard let tmpItems = items[j] as? [String:AnyObject]
                                    else{
                                        return
                                }
                                if tmpItems.indexForKey("comments") != nil {
                                    // the key exists in the dictionary
                                    
                                    guard   let tmpComment = tmpItems["comments"] as? String
                                        else{
                                            break                                        //return
                                    }
                                    tmpItem.comment  = tmpComment
                                }
                                else{
                                    tmpItem.comment = "" // provide empty sting if null
                                }
                                
                                
                                
                                
                                if tmpItems.indexForKey("quantity") != nil {
                                    // the key exists in the dictionary
                                    
                                        guard   let tmpQuantity = tmpItems["quantity"] as? Int
                                        else{
                                            return
                                    }
                                    tmpItem.quantity   = String(tmpQuantity)
                                }
                                else{
                                    tmpItem.quantity   = ""
                                }
                                    
                                    
                                if tmpItems.indexForKey("weight") != nil {
                                    // the key exists in the dictionary
                                    
                                    guard   let tmpWeight = (tmpItems["weight"]) as? Double
                                        else{
                                            return
                                    }
                                    tmpItem.weight   = String(tmpWeight)
                                }
                                else{
                                    tmpItem.weight   = ""
                                }

                                tmpItem.helpNeeded = (String(tmpItems["helpNeeded"]) == "true")
                                guard let product = tmpItems["product"] as? [String:AnyObject]
                                    else{
                                        return
                                }
                                let tmpName = (product["productName"] as? String)!
                                
                                tmpItem.name = tmpName
                                tmpItem.photo = store!.getPhoto (tmpDeliName, item: tmpName)
                                
                                tmpItem.orderNum = orderId
                                
                                
                                self.appendItem(tmpDeliName, item: tmpItem)
                                print ("added item \(orderId)")
                                
                                
                            }
                        }
                        newItem = false    
                    } // end for idx
                } //end if
                else{
                    print ("error in response")
                }
            } //end do
            catch let error as NSError {
                print(error.localizedDescription)
            }
            dispatch_semaphore_signal(orderSemaphore)
            print ("YYYY")
        }
        
        task.resume()
        
        print("before swm wait")
        if (dispatch_semaphore_wait(orderSemaphore, DISPATCH_TIME_FOREVER) != 0){
            print ("semaphore timedout with error")
        }//DISPATCH_TIME_FOREVER)
        
        
        // Perform cleanup on processed orders. 
        // orderId was not in the server reply and not empty
        
        orderRepositiryClean()
        
        
        print ("order load complete")
        //  return task
    }
    /*
    **  Build order in JSON format for all delies
    */
    
    func buldJsonOrder(deliId: Int) -> NSData{

        var orderDict = [String:AnyObject]()
        var itemArray = [AnyObject]()
        var itemElement = [String:AnyObject]()
        var productInfo = [String:AnyObject]()
        var quantity: Int?
        var quantuityStr: String
        var weight : Double
        var weightStr :String
        var deliDict = [String:AnyObject]()
        var customerDict = [String:AnyObject]()
        
        var data: NSData? = nil
        
        
            for j in 0..<deliOrders[deliId].items.count{
                
                // build OrderItem
                
                if (deliOrders[deliId].items[j].orderNum == "") {
                    
                    // Add only new items (empty orderNum)
                
                    quantuityStr = deliOrders[deliId].items[j].quantity
                    if (!quantuityStr.isEmpty)
                    {
                        quantity = Int(quantuityStr)!
                        itemElement["quantity"] = quantity
                    }
                    weightStr = deliOrders[deliId].items[j].weight
                    if (!weightStr.isEmpty)
                    {
                        weight = Double(weightStr)!
                        itemElement["weight"] = weight
                    }
                    itemElement["comments"] = deliOrders[deliId].items[j].comment
                    itemElement["helpRequired"] = Bool(deliOrders[deliId].items[j].helpNeeded)
                    
                    productInfo["productId"] = store!.getItemId(deliOrders[deliId].deliName,item: deliOrders[deliId].items[j].name)
                    itemElement["product"] = productInfo
                    
                    itemArray.append(itemElement)
                    
                }
            }
        
       
        
            
            deliDict["deliId"] = deliName2Id(deliOrders[deliId].deliName)
            orderDict["deli"] = deliDict
        
            orderDict["OrderItem"] = itemArray
            itemArray.removeAll()
        
            customerDict["customerId"] = 1
            orderDict["customers"] = customerDict
            
        
            // buld JSON from array
        
        
            if NSJSONSerialization.isValidJSONObject(orderDict) {
                do{
                    
                    data = try NSJSONSerialization.dataWithJSONObject(orderDict, options: NSJSONWritingOptions.PrettyPrinted)
                    if let myString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                        print (myString)
                  //      sentToNet(data)
                    }
                }
                catch{
                    print ("error in NSJSONSerialization")
                }
            }
        
        
        return data!
    }
    
    func sendOrder(jsonData: NSData){
        
        do {
            // create post request
            let url = NSURL(string: "http://192.168.1.103:8080/api/v1/orders?customer=1")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                
                do {
                    _ = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    
                    print("order added")
                    
                } catch {
                    print("Catch Error -> \(error)")
                }
            }
            
            task.resume()
            //  return task
            
            
            
        }
    }
    
    func updateNewOrder(orderId: String){
        newOrder.append(orderId)
    }
    
    func findInNewOrder(orderId: String) -> Bool {
        for i in 0..<newOrder.count{
            if newOrder[i] == orderId{
                return true
            }
        }
        return false
    }
    
    func orderRepositiryClean(){
        
        //var toRemove = [Int](count: 100, repeatedValue: 0)
        var removeOrderCount = 0
        var removeItemCount = 0
        var i: Int
        var j: Int
        
        i = 0
        while i < (orderTracking.count - removeOrderCount){
            if !findInNewOrder(orderTracking[i].orderNum){
                
                //remove order
                
                removeItemCount = 0
                let deliId: Int = deliName2Id(orderTracking[i].deliName) - 1
                j = 0
                while j < (deliOrders[deliId].items.count - removeItemCount){
                    if (deliOrders[deliId].items[j].orderNum == orderTracking[i].orderNum) {
                        deliOrders[deliId].items.removeAtIndex(j)
                        removeItemCount += 1
                    }
                    else{
                        j += 1
                    }
                }
                print("removed oreder \(orderTracking[i].orderNum)")
                orderTracking.removeAtIndex(i)
                removeOrderCount += 1
            }
            else{
                i += 1
            }
        }
        newOrder.removeAll()
    }
    
    func orderRepositiryCleanNew(){
        
        var removeItemCount = 0
        var j: Int
        
        for i in 0..<deliOrders.count{
            
            removeItemCount = 0
            j = 0
            while j < (deliOrders[i].items.count - removeItemCount){
                if ((deliOrders[i].items[j].orderNum == "")){
                    
                    print("removed new item from \(deliOrders[i].items[j].name)")
                    deliOrders[i].items.removeAtIndex(j)
                    removeItemCount += 1
                }
                else{
                    j += 1
                }
            }
           
        }
    }

    
    func checkNewItems(deliIdx: Int) -> Bool{
        
        var ret: Bool = false
        
        for i in 0..<deliOrders[deliIdx].items.count{
            if deliOrders[deliIdx].items[i].orderNum == "" {
                ret = true
                break
            }
        }
        return ret
    }
}



   