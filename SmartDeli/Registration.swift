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
    
}