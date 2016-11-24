//
//  CustomLevelCell.swift
//  UASapp
//
//  Created by Italo Fernández Salgado on 11/24/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CustomLevelCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
