//
//  NewItemDetailView.swift
//  DeliTest
//
//  Created by Zeev Gross on 03/07/2016.
//  Copyright © 2016 Zeev Gross. All rights reserved.
//


import UIKit

class NewItemDetailView: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Proprties
    
    
    var item: productItem? = nil
    
    @IBOutlet weak var newItemImage: UIImageView!
    @IBOutlet weak var newItemQuantity: UITextField!
    @IBOutlet weak var newItemWeight: UITextField!
    @IBOutlet weak var careNeededSwitch: UISwitch!
    @IBOutlet weak var newItemComment: UITextView!
    @IBOutlet weak var saveButton: UIButton!
   
    @IBOutlet weak var scrollView: UIScrollView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        // Handle the text field’s user input through delegate callbacks.

        newItemQuantity.delegate = self
        newItemWeight.delegate = self
        newItemComment.delegate = self
        scrollView .delegate = self
        
        if let item = item {
            newItemWeight.text   = item.weight
            newItemQuantity.text = item.quantity
            newItemImage.image   = item.photo
            careNeededSwitch.on  = item.helpNeeded
            newItemComment.text  = item.comment
        }
        
        newItemComment.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        newItemComment.layer.borderWidth = 1.0
        newItemComment.layer.cornerRadius = 5
   
  
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
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        //checkValidMealName()
        navigationItem.title = textField.text
        saveButton.enabled = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    

    // MARK: UITextViewDelegate
    func textViewDidBeginEditing(textView: UITextView) {
        let scrollPoint : CGPoint = CGPointMake(0, self.newItemComment.frame.origin.y)
        self.scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if saveButton === sender {
        
        // let item = item {
        // let item = productItem()
                item!.weight     = newItemWeight.text!
                item!.quantity   = newItemQuantity.text!
                item!.photo      = newItemImage.image
                item!.helpNeeded = careNeededSwitch.on
                item!.comment    = newItemComment.text
       
        //    }
        }
    }
    
    @IBAction func updateOrderField(sender: UITapGestureRecognizer) {
    
        // Hide the keyboard
        
        newItemQuantity.resignFirstResponder()
        newItemWeight.resignFirstResponder()
        newItemComment.resignFirstResponder()
    
    }
}
