//
//  CustomCourseCell.swift
//  UASapp
//
//  Created by inf227al on 27/10/16.
//  Copyright © 2016 sumajg. All rights reserved.
//

import UIKit

class CustomCourseCell: UITableViewCell {

    @IBOutlet var lblSchedule: UILabel!
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var lblCourse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
