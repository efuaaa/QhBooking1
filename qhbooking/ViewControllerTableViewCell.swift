//
//  ViewControllerTableViewCell.swift
//  qhbooking
//
//  Created by Qodehub-intern on 27/07/2018.
//  Copyright © 2018 Qodehub. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var purposeLabel: UILabel!
    
    @IBOutlet weak var StartTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
