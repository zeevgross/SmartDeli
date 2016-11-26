//
//  order.swift
//  DeliTest
//
//  Created by Zeev Gross on 18/09/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

//import Foundation
import UIKit


struct orderId
{
    var deliName: String
    var orderNum: String
    
    init()
    {
        deliName = ""
        orderNum = ""
    }
}


struct orderRsponse
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
    var orderTracking = [orderRsponse] ()
    var orderResponseTest = [orderId] ()
    var storeId: Int
    
    // MARK: Initialization
    
    init?(mail: String, store: String) {
        // Initialize stored properties.
        self.customerMail = mail
        self.storeName = store
        self.storeId = 555
        super.init()
        
        // Initialization should fail if there is no email address
        if mail.isEmpty {
            return nil
        }
        debugFill()
        buildDelies()
        
    }
    
    func buildDelies(){
        
        let deliNames = ["Beef","Cheese","Poultry","Fish"]
        var deli:DeliOrder
        
        let size = deliNames.count
        
        for i in 0..<size
        {
            deli = DeliOrder(deliName: deliNames[i])!
            deliOrders.append(deli)
        }
        
    }
    
    
    
    func debugFill(){
        
        var ord = orderId()
        
        ord.deliName = "Beef"
        ord.orderNum = "1234"
        orderResponseTest.append (ord)

        ord.deliName = "Fish"
        ord.orderNum = "5678"
        orderResponseTest.append (ord)
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

   /*
    struct tmpProduct {
        var name: String
        var photo: UIImage?
        var quantity: String
        var weight: String
        var comment: String
        var helpNeeded: Bool

    }
    */
    
    func appendItem(deliName :String, item: productItem){
        
        let myTmp = item
    /*
        myTmp.name = item.name
        myTmp.photo = item.photo
        myTmp.quantity = item.quantity
        myTmp.weight = item.weight
        myTmp.comment = item.comment
        myTmp.helpNeeded = item.helpNeeded
    */
        for i in 0..<deliOrders.count {
            if deliOrders[i].deliName == deliName{
                    deliOrders[i].items.append(myTmp)
      /*
                let size = deliOrders[i].items.count
                let index = size - 1
                
                deliOrders[i].items[index].name = name
                deliOrders[i].items[index].photo = photo
                deliOrders[i].items[index].quantity = quantity
                deliOrders[i].items[index].weight = weight
                deliOrders[i].items[index].comment = comment
                deliOrders[i].items[index].helpNeeded = helpNeeded
       */
            }
        }
    }
   
    func pollOrderStatusRequest(orderList: [orderId]){
        
        var itemDictionary: NSDictionary = [
            "deliName":"",
            "orderId":""
        ]
        let orderpoll: NSMutableArray = []
        
        // load items into array with the order ID values
        
        let size = orderList.count
        for i in 0 ..< size
        {
 
            itemDictionary = [
                "deliName":orderList[i].deliName,
                "orderId":String(orderList[i].orderNum)
            ]
            orderpoll.addObject(itemDictionary)
        }
        
        let queryOrder: NSDictionary = [
            "custofmer":"zeev.gross.work@gmail.com",
            "store":"1234",
            "deliOrder": orderpoll
        ]
        
        
        // buld JSON from array
        
        
        if NSJSONSerialization.isValidJSONObject(queryOrder) {
            do{
                
                let data = try NSJSONSerialization.dataWithJSONObject(queryOrder, options: NSJSONWritingOptions.PrettyPrinted)
                if let myString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    print (myString)
                    sentToNet(data)
                }
            }
            catch{
                print ("error in NSJSONSerialization")
            }
        }
       
    }
    
    func sentToNet1(jsonData: NSData){
        
        do {
            let url = NSURL(string: "http://echo.jsontest.com/key/value/one/two")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            
            //print ("Request -> \(request)")
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    
                    print("Result -> \(result)")
                    
                } catch {
                    print("Catch Error -> \(error)")
                }
            }
            
            task.resume()
            //  return task
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
            case  "Beef": id=1
            case  "Cheese": id=2
            case  "Fish": id=3
            case  "Poultry": id=4
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

    
    func handleNewResponse ()
    {
        var found: Bool = false
        var orderId: String
        var new: Bool = false
       // var item =  productItem(name: "stam", photo: nil, quantity: "0",weight: "0", comment: "", helpNeeded: false)
        
        var tmpDeliResponse =  orderRsponse()
        var item =  productItem()
        
        
        //item  productItem(name: "stam", photo: nil, quantity: "0",weight: "0", comment: "", helpNeeded: false)!
        
        if let asset = NSDataAsset(name: "status", bundle: NSBundle.mainBundle()){
        
        do {
            let result = try NSJSONSerialization.JSONObjectWithData(asset.data, options: []) as? [String:AnyObject]
            
            
            guard let Store = result!["store"] as? [String:AnyObject]
                else{
                    return
            }
            
            guard let tmpStore = Store["name"] as? String
                else{
                    return
            }
            storeName = tmpStore
            
            guard let tmpStoreId = Store["id"] as? Int
                else{
                    return
            }
            storeId = tmpStoreId
            
            guard let deliesArray = Store["delies"] as? [AnyObject]
                else{
                    return
                }
            
            for i in 0..<deliesArray.count
            {
                guard let deli = deliesArray[i] as? [String:AnyObject]
                    else{
                        return
                }
               
                // Process Deli Order
                
                let deliOrderId:Int = (deli["id"] as? Int)!
                let tmpDeliName = deliId2Name((deli["deliId"] as? Int)!)
                orderId = String(deliOrderId)

                for j in 0..<orderTracking.count
                {
                    if (orderTracking[j].orderNum == orderId){
                        found = true
                        print ("updated")
                        
                        // Update fields
                        orderTracking[j].estimedTime = (deli["eta"] as? String)!
                        orderTracking[j].startTime = (deli["created"] as? String)!
                        new = false
                    }
                }
                
                if found == false{
                    
                    // Add new entry
                    
                    tmpDeliResponse.orderNum = orderId
                    tmpDeliResponse.deliName = tmpDeliName
                    tmpDeliResponse.estimedTime = (deli["eta"] as? String)!
                    tmpDeliResponse.startTime = (deli["created"] as? String)!
                    orderTracking.append(tmpDeliResponse)
                    
                    new = true
                }

                
                // process items (not required !!)
                
                guard let items = deli["items"] as? [AnyObject]
                    else{
                        return
                }
                
                for j in 0..<items.count
                {
                   
                    guard let tmpItems = items[j] as? [String:AnyObject]
                        else{
                            return
                    }

                    
                    
                    if new == true  {

                        guard   let tmpComment = tmpItems["comments"] as? String
                            else{
                                return
                        }
                        item.comment  = tmpComment
                      
                        if tmpItems.indexForKey("quantity") != nil {
                            // the key exists in the dictionary
                            
                            guard   let tmpQuantity = tmpItems["quantity"] as? Int
                                else{
                                    return
                            }
                            item.quantity   = String(tmpQuantity)
                        }
                        
                        if tmpItems.indexForKey("weight") != nil {
                            // the key exists in the dictionary
                            
                            guard   let tmpWeight = (tmpItems["weight"]) as? Double
                                else{
                                    return
                            }
                            item.weight   = String(tmpWeight)
                        }

                        item.helpNeeded = (String(tmpItems["helpNeeded"]) == "true")
                        
                        guard let product = tmpItems["product"] as? [String:AnyObject]
                            else{
                                return
                        }
                        let tmpName = (product["name"] as? String)!
                        
                        item.name = (product["name"] as? String)!
                        item.photo = store!.getPhoto (tmpDeliName, item: tmpName)
                    
                        appendItem(tmpDeliName, item: item)
                    
                    }
                    else{
                        deliOrders[i].items[j].quantity   = String(tmpItems["quantity"])
                        deliOrders[i].items[j].weight     = String(tmpItems["weight"])
                        deliOrders[i].items[j].comment    = String(tmpItems["comment"])
                        deliOrders[i].items[j].helpNeeded = (String(tmpItems["helpNeeded"]) == "true")
                    }
                }
            }
        }
            catch {
                print("Catch Error -> ")
        }
        }
     }


    /*
    **  Build order in JSON format for all delies
    */
    
    func buldJsonOrder(){

        var storeDict = [String:AnyObject]()
        var orderDict = [String:AnyObject]()
        var deliArray = [AnyObject]()
        var deliDict = [String:AnyObject]()
        var itemArray = [AnyObject]()
        var itemElement = [String:AnyObject]()
        var productInfo = [String:AnyObject]()
        var  quantity: Int?
        var quantuityStr: String
        var weight : Double
        var weightStr :String
        
        for i in 0..<deliOrders.count{
            
            for j in 0..<deliOrders[i].items.count{
                
                quantuityStr = deliOrders[i].items[j].quantity
                if (!quantuityStr.isEmpty)
                {
                    quantity = Int(quantuityStr)!
                    itemElement["quantity"] = quantity
                }
                
                weightStr = deliOrders[i].items[j].weight
                if (!weightStr.isEmpty)
                {
                    weight = Double(weightStr)!
                    itemElement["weight"] = weight
                }

                itemElement["comments"] = deliOrders[i].items[j].comment
                itemElement["helpRequired"] = Bool(deliOrders[i].items[j].helpNeeded)
                productInfo["id"] = store!.getItemId(deliOrders[i].deliName,item: deliOrders[i].items[j].name)
                productInfo["name"] = deliOrders[i].items[j].name
                itemElement["product"] = productInfo
                
                itemArray.append(itemElement)
            }
            deliDict["deliName"] = deliOrders[i].deliName
            deliDict["deliId"] =  deliName2Id(deliOrders[i].deliName)
            deliDict["items"] = itemArray
            
            deliDict["created"] =  "29-10-2016 10:50:00"
                        
            deliArray.append(deliDict)
            itemArray.removeAll()
            
        }
        
        orderDict["name"] = "Rishon"
        orderDict["id"] = 3
        orderDict["delies"] = deliArray
        
        
        storeDict["store"] = orderDict
        
        // buld JSON from array
        
        
        if NSJSONSerialization.isValidJSONObject(storeDict) {
            do{
                
                let data = try NSJSONSerialization.dataWithJSONObject(storeDict, options: NSJSONWritingOptions.PrettyPrinted)
                if let myString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    print (myString)
              //      sentToNet(data)
                }
            }
            catch{
                print ("error in NSJSONSerialization")
            }
        }
    }
    
    func sentToNet(jsonData: NSData){
        
        do {
            
            //      let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            // create post request
            //            let url = NSURL(string: "http://192.168.1.149/zeev.html")!
            let url = NSURL(string: "http://echo.jsontest.com/key/value/one/two")!
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
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    
                    print("Result -> \(result)")
                    
                } catch {
                    print("Catch Error -> \(error)")
                }
            }
            
            task.resume()
            //  return task
            
            
            
        }
    }

    
    
    func sendGetCustomerOrder(customerId: Int64)
    {
        let urlStr = "http://84.94.180.127:8080/api/v1/orders?customer=" + String(customerId)
        
        let url = NSURL(string: urlStr)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        // insert json data to the request
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                
                print("Result -> \(result)")
                
            } catch {
                print("Catch Error -> \(error)")
            }
        }
        
        task.resume()
        //  return task
        
    }

}



   