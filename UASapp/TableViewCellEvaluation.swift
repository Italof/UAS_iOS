//
//  TableViewCellEvaluation.swift
//  UASapp
//
//  Created by inf227al on 16/11/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class TableViewCellEvaluation: UITableViewCell {

    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var avance: UILabel!
    @IBOutlet weak var vigencia: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
