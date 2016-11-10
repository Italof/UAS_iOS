//
//  TableViewCellStudent.swift
//  UASapp
//
//  Created by inf227al on 26/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class TableViewCellStudent: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var tutor: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var code: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
