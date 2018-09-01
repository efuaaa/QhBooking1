//
//  BookingModel.swift
//  qhbooking
//
//  Created by Qodehub-intern on 27/07/2018.
//  Copyright © 2018 Qodehub. All rights reserved.
//

import UIKit


    
    
    
    class BookingModel {
        
        var id: String?
        var fullname: String?
        var purpose: String?
        var startTime: String?
         var endTime: String?
        
        init(id: String?, fullname: String?, purpose: String?, startTime: String?, endTime: String? ){
            self.id = id
            self.fullname = fullname
            self.purpose = purpose
            self.startTime = startTime
            self.endTime = endTime
            
        }
    }

    

