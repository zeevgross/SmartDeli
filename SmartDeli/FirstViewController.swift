//
//  FirstViewController.swift
//  DeliTest
//
//  Created by Zeev Gross on 18/06/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

var store = storeInventory(name: "Rishon", id: 123)

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Proprties
    
    
    @IBOutlet weak var branchSelection: UIPickerView!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    let pickerData = ["Jerusalem", "Tel Aviv", "Rishon", "Bat Yam", "Holon", "Ramat Gan", "Givatayyim","Modiin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        branchSelection.dataSource = self
        branchSelection.delegate = self
        
        //userName.text = "Zeev"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        branchLabel.text = pickerData[row]
    }

 /*   @IBAction func processLogin(sender: AnyObject) {
        print ("login pressed !!")
        
        //store!.loadStoreinventory()
        //print("Inventory loaded")


    }
  */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if loginButton === sender {
            print ("login pressed !!")
            store!.loadStoreinventory()
            print("Inventory loaded")
        
        }
    }

}