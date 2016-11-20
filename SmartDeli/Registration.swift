//
//  Registration.swift
//  DeliTest
//
//  Created by Zeev Gross on 21/09/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//

import UIKit

class Registration: NSObject  {
    
    // MARK: Properties
    
    var firstName:      String
    var lastName:       String
    var birthDate:      String
    var userName:       String
    var mailAddr:       String
    var password:       String
    var passwordCopy:   String
    
    // MARK: Initialization
    
    init?(firstName: String, lastName: String, birthDate: String, userName: String, mailAddr: String, password: String, passwordCopy: String){
        
        // Initialize stored properties.
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.userName = userName
        self.mailAddr = mailAddr
        self.password = password
        self.passwordCopy = passwordCopy
        
        super.init()
        
    }
    
    

func validateUser()->Bool{
    
    var ret: Bool  = true
    
        if ((self.firstName.isEmpty) || (self.firstName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 3))
        {
            print ("error in first name")
            ret =  false
        }
    
        if ((self.lastName.isEmpty) || (self.lastName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 3))
        {
            print ("error in Last name")
            ret =  false
        }
        if ((self.birthDate.isEmpty) || (self.birthDate.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 8))
        {
            print ("error in birth date name")
            ret =  false
        }
        if ((self.mailAddr.isEmpty) || (self.mailAddr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 3))
        {
            print ("error in E-mail Address name")
            ret =  false
        }
        if ((self.passwordCopy.isEmpty) || (self.firstName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 3))
        {
            print ("error in password name")
            ret =  false
        }
        if (password != passwordCopy){
            print (" pasword does not match the password copy")
            ret = false
        }

    
        return ret
    }
    
    
    // JSON TESTS
/*
    func testJSON(){
        
    //    let JSONData = NSData(self)
        let JSONData :Data = data(selfwithJSONObject obj:  self, options opt: JSONSerialization.WritingOptions = true)
        do {
            let JSON = try NSJSONSerialization.JSONObjectWithData(JSONData, options:NSJSONReadingOptions(rawValue: 0))
            guard let JSONDictionary: NSDictionary = JSON as? NSDictionary else {
                print("Not a Dictionary")
                // put in function
                return
            }
            print("JSONDictionary! \(JSONDictionary)")
        }
        catch let JSONError as NSError {
            print("\(JSONError)")
        }
    }*/
}

/*

extension Registration {
    
    init?(json: [String: Any]) {
        guard let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
            let birthDate = json["birthDate"] as? String,
            let userName = json["userName"] as? String,
            let mailAddr = json["mailAddr"] as? String,
            let password = json["password"] as? String,
            let passwordCopy = json["passwordCopy"] as? String
            else {
                return nil
            }
    }

    let json["firstName"] = self.firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.userName = userName
        self.mailAddr = mailAddr
        self.password = password
        self.passwordCopy = passwordCopy
    
}
*/