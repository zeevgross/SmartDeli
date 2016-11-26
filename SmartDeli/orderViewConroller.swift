//
//  orderViewConroller.swift
//  DeliTest
//
//  Created by Zeev Gross on 30/10/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

class orderViewController: UITableViewController {
    
    
    //var order = CustomerOrder(mail: "zeev.gross.work@gmail.com", store: "8888")
    var sortedOder = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load the data
        
        
        order!.pollOrderStatusRequest(order!.orderResponseTest)
        order!.handleNewResponse()
        sortByETA()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = order!.orderTracking.count
        return count
    }
    
    // Override to support editing the table view.
    
    
    func toDateTime(strDate: String) -> NSDate
    {
        //Create Date Formatter
        let dateFormatter = NSDateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.dateFromString(strDate)!
        
        //Return Parsed Date
        return dateFromString
    }

    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "orderTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! orderTableViewCell
        
        let index = sortedOder[indexPath.row]
        
        // Fetches the appropriate meal for the data source layout.
        let deliOrder = order!.orderTracking[index]
      /*
        cell.itemName.text = item.name
        cell.itemPhoto.image = item.photo
        cell.itemComment.text = item.comment
      */
        
        
        let orderCurrentDate: String = "29-10-2016 10:50:00"
        
        let s1: NSDate = toDateTime(deliOrder.startTime)
        let s2: NSDate = toDateTime(deliOrder.estimedTime)
        let c1: NSDate = toDateTime(orderCurrentDate)
        
        let interval = s2.timeIntervalSinceDate(s1)
        let remain = s2.timeIntervalSinceDate(c1)
        let intervalText: String = String(Int(remain/60)) + ":" + String(format: "%02d", Int(remain%60))
        
        // calc Progress bar
        
        let ratio = c1.timeIntervalSinceDate(s1) / interval
        
        cell.deliName.text = deliOrder.deliName + " Deli"
        cell.progrssBar.progress = Float(ratio)
        cell.timeValue.text = intervalText
        cell.photo.image = deliImage(deliOrder.deliName)
        
        return cell
    }
    
    func deliImage(deliName: String) ->UIImage {
        
        var imageName:String = ""
        
        switch deliName {
        
        case "Beef":
            imageName = "BeefDeli"
        case "Fish":
            imageName = "FishDeli"
        case "Cheese":
            imageName = "CheeseDeli"
        case "Poultry":
            imageName = "PoultryDeli"

        default:
            imageName = ""
        }
        
        return UIImage(named: imageName)!
    }
    
    func sortByETA () {
        
        var refVal:Int = Int.max
        
        var used = [Int](count: 10, repeatedValue: 0)
        
        var prevRef = 0
        var index:Int = 0
        
        for _ in 0..<order!.orderTracking.count
        {
            
            for j in 0..<order!.orderTracking.count
            {
                let orderCurrentDate: String = "29-10-2016 10:50:00"
                
                //let s1: NSDate = toDateTime(order!.orderTracking[j].startTime)
                let s2: NSDate = toDateTime(order!.orderTracking[j].estimedTime)
                let c1: NSDate = toDateTime(orderCurrentDate)
                let interval = Int(s2.timeIntervalSinceDate(c1))
                if  ((interval < refVal) && (interval >= prevRef) && (used[j] == 0))
                {
                    index = j
                    refVal = interval
                }
                
            }
            sortedOder.append (index)
            used[index] = 1
            prevRef = refVal
            refVal = Int.max
        }
        //print("sort -> \(sortedOder)")
        
    
    }
    
}
