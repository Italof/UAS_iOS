//
//  CustomCriterioCell.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CustomCriterioCell: UITableViewCell {

    @IBOutlet var lblCriterio: UILabel!
    @IBOutlet var lblGrade: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //lblCriterio.adjustsFontSizeToFitWidth=true
        //lblCriterio.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
