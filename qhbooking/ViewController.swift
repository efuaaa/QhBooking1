//
//  ViewController.swift
//  qhbooking
//
//  Created by Qodehub-intern on 24/07/2018.
//  Copyright © 2018 Qodehub. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

     var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    
   
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    var BookingsList = [BookingModel]()
    
    
    override func viewDidLoad() {
        //    showLoadingScreen()
        
        self.loadingLabel.isHidden = false
        self.tableView.isHidden = true
        super.viewDidLoad()
    
        
        //Set the firebase reference
        ref = Database.database().reference().child("recordslist")
        
        
        //Retrieve booking records and listen for changes
//        databaseHandle = ref?.child("qhbooking").observe(.childAdded, with: { (Datasnapshot) in
        ref?.observe(DataEventType.value, with: { (Datasnapshot) in
                    if Datasnapshot.childrenCount > 0 {
            
                        //clearing the list
                      self.BookingsList.removeAll()
            
                        //iterating through all the values
                        for records in Datasnapshot.children.allObjects as! [DataSnapshot] {
                            //getting values
                            let recordObject = records.value as? [String: AnyObject]
                            
                            let Id  = recordObject?["BookingId"]
                            let Purpose = recordObject?["Purpose"]
                            let FullName  = recordObject?["Fullname"]
                            let StartTime = recordObject?["StartTime"]
                            let EndTime = recordObject?["EndTime"]
                            //creating artist object with model and fetched values
                            let record = BookingModel(id: Id as! String?, fullname: FullName as! String?, purpose: Purpose as! String?, startTime: StartTime as! String?, endTime: EndTime as! String?)
            
                            //appending it to list
                       
                             self.BookingsList.append(record)
                           
                               
                            
                        }
            
                        //reloading the tableview
                        self.BookingsList = self.BookingsList.reversed()
                        
//
                        self.tableView.reloadData()
                       self.loadingLabel.isHidden = true
                        self.tableView.isHidden = false
                        
                    }
            
        })
       
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! ViewControllerTableViewCell
        
//        cell?.textLabel?.text = BookingsList[indexPath.row]
        
       
          tableView.estimatedRowHeight = 145
          tableView.rowHeight = 100 ;
        
        
          //the booking object
          let booking:BookingModel
        
          //getting the artist of selected position
          booking = BookingsList[indexPath.row]
        
          //adding values to labels
        
          cell.nameLabel.text = "\( booking.fullname ?? "" )"
          cell.purposeLabel.text = "\(booking.purpose ?? "")"
          cell.StartTimeLabel.text = "\( booking.startTime ?? "" ) to \(booking.endTime ?? "")"
        
        
          //cell.StartTimeLabel?.text = "Purpose : \(String(describing: booking.))"
        
          //returning cell
        
        
        return cell
    }
    
    

    
    

    
    
    
//    func showLoadingScreen(){
//        loadingView.bounds.size.width = view.bounds.width
//        loadingView.bounds.size.height = view.bounds.height
//        loadingView.center = view.center
//        loadingView.alpha = 1
//
//
//        view.addSubview(loadingView)
//
//        UIView.animate(withDuration: 8, delay: 0.5, options: [], animations: {
//            self.loadingView.alpha = 0
//        })
//
//    }


}

