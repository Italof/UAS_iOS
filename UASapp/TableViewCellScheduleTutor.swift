//
//  TableViewCellScheduleTutor.swift
//  UASapp
//
//  Created by inf227al on 15/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class TableViewCellScheduleTutor: UITableViewCell {
    
    
    @IBOutlet weak var hora: UILabel!
    
    @IBOutlet weak var hL: UILabel!
    @IBOutlet weak var hMa: UILabel!
    @IBOutlet weak var hMi: UILabel!
    @IBOutlet weak var hJ: UILabel!
    @IBOutlet weak var hV: UILabel!
    @IBOutlet weak var hS: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
