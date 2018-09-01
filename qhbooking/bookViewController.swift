//
//  bookViewController.swift
//  qhbooking
//
//  Created by Tutorials & Tools on 25/07/2018.
//  Copyright © 2018 Qodehub. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase




class bookViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate, UIPickerViewDataSource{
    
   
    var ref: DatabaseReference?
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//
//    for item in snapshot.children{
//    if let itemValue = (item as? FIRDataSnapshot).value as? String, let s = s, s.contains(itemValue){
//
//    }
//    }
    
   
   
    @IBAction func SavetoFirebase(_ sender: Any) {
//        Post to firebase
       
     
        if ((self.nameField.text?.isEmpty)! || (self.purposeField.text?.isEmpty)! || (self.dur1.text?.isEmpty)! || (self.dur2.text?.isEmpty)!) {
            label1.text = "All fields are required"
            label1.isHidden = false
            
           
        }
        
        
        else{
            let key = self.ref?.childByAutoId().key
            //creating the list with the given values
            let bookinglist = ["BookingId":key,
             "Fullname": self.nameField.text! as String,
            "Purpose": self.purposeField.text! as String,
            "StartTime": self.dur1.text! as String,
            "EndTime": self.dur2.text! as String]
            self.ref?.child(key!).setValue(bookinglist)
            self.navigationController?.popViewController(animated: true)
            
        }
        
//        else if ((self.dur1.text?.isEmpty) != nil)
//
//        {
//
//
////            ref?.observeSingleEvent(of: .value, with: { (snapshot) in
//             ref?.observe(DataEventType.value, with: { (Datasnapshot) in
//
//                if Datasnapshot.hasChild(self.dur1.text!){
//
//                    self.label1.text = "time unav"
//
//                }
//                else{
//
//
//                     self.label1.text = "saved"
//
////                    let key = self.ref?.childByAutoId().key
////                    //creating the list with the given values
////                    let bookinglist = ["BookingId":key,
////                                       "Fullname": self.nameField.text! as String,
////                                       "Purpose": self.purposeField.text! as String,
////                                       "StartTime": self.dur1.text! as String,
////                                       "EndTime": self.dur2.text! as String]
////                    self.ref?.child(key!).setValue(bookinglist)
////                    self.navigationController?.popViewController(animated: true)
//                }
//
//
//            })
//        }
        
    }
    
   
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var purposeField: UITextField!
    
    @IBOutlet weak var dur1: UITextField!
    
    @IBOutlet weak var dur2: UITextField!
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var label1: UILabel!
    
  
    
    var myList = ["8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00"]
    
    var myList2 = ["8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00"]
    var temp =  ["8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00"]
    
    var isSlected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("recordslist")

//        self.picker1.delegate = self
//        self.picker1.dataSource = self
//        self.picker2.delegate = self
//        self.picker2.dataSource = self
//
        self.nameField.delegate = self
        
        picker1.isHidden = true
        picker2.isHidden = true
        label1.isHidden = true
       
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        picker1.isHidden = true
        picker2.isHidden = true
        
    }
    
    @IBAction func didSelectedStartTimeTextField(_ sender: Any) {
        picker1.isHidden = false
        picker2.isHidden = true
        dur2.text = ""
        
        myList = myList2
        
    }
    
    @IBAction func didSelectEndTimeTextField(_ sender: Any) {
        if dur1.text?.isEmpty == false{
            picker2.isHidden = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedText = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz- ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedText.isSuperset(of: characterSet)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if pickerView == picker1 {
            return temp.count
            
        }
        return myList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == picker2 {
            
            if !isSlected {
               return temp[row]
            }
            if row >= (temp.count)
            {
                 return "N/A"
            }
            return self.temp[row]
            
        }
        if pickerView == picker1 {
             return myList[row]
        }
        return nil;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1{
         self.temp = []
         self.dur1.text = self.myList[row]
         self.isSlected = true
         self.picker1.isHidden = true
            
            for i in 0...((self.myList.count - 1)){
                if i  > row && (i <= (row + 4)){
                    
                    self.temp.append(self.myList[i])
                }
            }
         
            
         self.picker2.reloadAllComponents()
            
         
        }
        
        else if pickerView == picker2{
            
        
            if row >= (temp.count)
            {
                self.dur2.text = ""
                 self.picker2.isHidden = false
            }
            else {
                self.dur2.text = temp[row]
                self.picker2.isHidden = true
            }
       
         
           
        }
        
        
        
        
    }
    
  

}



