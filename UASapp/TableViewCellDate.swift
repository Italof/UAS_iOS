//
//  TableViewCellDate.swift
//  UASapp
//
//  Created by inf227al on 24/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class TableViewCellDate: UITableViewCell {

    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var theme: UILabel!    
    @IBOutlet var student: UILabel!
    @IBOutlet var status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
