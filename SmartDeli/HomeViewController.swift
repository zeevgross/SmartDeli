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
        
        //order!.handleNewResponse()
        
        
        order!.buldJsonOrder()
        
       // pollOrder()
        
        // Start Timer
        /*
        if timerUsed{
            pollTimer.invalidate()
            timerUsed = false
        }
        else{
            pollTimer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector: #selector(HomeViewController.pollOrder), userInfo: nil, repeats: true)
            timerUsed = true
        }
         */
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
        
    
        //order!.pollOrderStatusRequest(order!.orderResponseTest)
        order!.handleNewResponse()
    
    }
    
}
