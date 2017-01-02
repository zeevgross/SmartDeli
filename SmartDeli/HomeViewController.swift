//
//  HomeViewController.swift
//  DeliTest
//
//  Created by Zeev Gross on 26/06/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //var order = CustomerOrder(mail: "zeev.gross.work@gmail.com", store: "8888")
    var pollTimer = NSTimer()
    var timerUsed = false
    
    @IBAction func updateStatus(sender: AnyObject) {
        print ("update pressed")
        
        var data: NSData
        
        for i in 0..<4{
            
           
            if ((order!.getItemsCount(order!.deliId2Name(i+1)) > 0) && (order!.checkNewItems(i))) {
                data = order!.buldJsonOrder(i)
                if order != nil {
                    order!.sendOrder(data)
                }
            }
        }
        
        order!.orderRepositiryCleanNew()
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            order!.getOrderFromServer()
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
       // order = CustomerOrder(mail: "zeev.gross.work@gmail.com", store: "1234")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pollOrder(){
        
    
        
        order!.getOrderFromServer()
    
    }
    
}
