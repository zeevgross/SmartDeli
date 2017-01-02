//
//  RegistrationViewController.swift
//  DeliTest
//
//  Created by Zeev Gross on 20/09/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//


import UIKit
import Foundation

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Proprties
    
    var user: Registration? = nil
    
 
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var mailAddr: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordCopy: UITextField!

    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //userName.text = "Zeev"
        
        firstName.delegate = self
        lastName.delegate = self
        birthDate.delegate = self
        userName.delegate = self
        mailAddr.delegate = self
        password.delegate = self
        passwordCopy.delegate = self
   
 /*       if let user = user {
            
            user.firstName = ""
            user.lastName = ""
            user.birthDate = ""
            user.userName = ""
            user.mailAddr = ""
            user.password = ""
            user.passwordCopy = ""
 
        }
  */      
        firstName.text = ""
        lastName.text = ""
        birthDate.text = ""
        userName.text = ""
        mailAddr.text = ""
        password.text = ""
        passwordCopy.text = ""
     
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
 
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }

    @IBAction func registerAction(sender: AnyObject) {

        let fName: String = firstName.text!
        let lName: String = lastName.text!
        let bDate: String = birthDate.text!
        let uName: String = userName.text!
        let mAddr: String = mailAddr.text!
        let pass: String = password.text!
        let passCopy: String = passwordCopy.text!
        
        //let user: Registration
        if registerButton === sender {
      
            user = Registration(firstName: fName, lastName: lName, birthDate: bDate, userName: uName, mailAddr: mAddr, password: pass, passwordCopy: passCopy)
            print ("Register button pressed")
            if (!user!.validateUser()){
                print ("Error in user fields")
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print ( "sender= \(sender)")
        if registerButton === sender {
            
            
            let fName: String = firstName.text!
            let lName: String = lastName.text!
            let bDate: String = birthDate.text!
            let uName: String = userName.text!
            let mAddr: String = mailAddr.text!
            let pass: String = password.text!
            let passCopy: String = passwordCopy.text!
            
            //let user: Registration
            
                user = Registration(firstName: fName, lastName: lName, birthDate: bDate, userName: uName, mailAddr: mAddr, password: pass, passwordCopy: passCopy)
                print ("Register button pressed")
                if (!user!.validateUser()){
                    print ("Error in user fields")
                    return
                }
            
            
                // Build JSON object 
            
                let regDictionary: NSDictionary = [
                    "first_name" :  firstName.text!,
                    "last_name":    lastName.text!,
                    "birth_date" :  birthDate.text!,
                    "username" :    userName.text!,
                    "email":        mailAddr.text!
                    /*,
                    "password":     password.text!,
                    "passwordCopy": passwordCopy.text! */
                ]
            
            
                if NSJSONSerialization.isValidJSONObject(regDictionary) {
                 
                    do{
                      
                        let data = try NSJSONSerialization.dataWithJSONObject(regDictionary, options: NSJSONWritingOptions.PrettyPrinted)
                            if let myString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                                print (myString)
                                sendToServer(data)
                        }
                    }
                    catch{
                            print ("error in NSJSONSerialization")
                    }
                }
                    
            }
    }
    
    
    
    func sendToServer(jsonData: NSData){
        
        do {
            let url = NSURL(string: "http://192.168.1.103:8080/api/v1/customers")!
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

}
