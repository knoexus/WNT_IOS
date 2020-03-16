//
//  MyApplicationCellTableViewCell.swift
//  WNT
//
//  Created by AD on 16.03.2020.
//  Copyright © 2020 AD. All rights reserved.
//

import UIKit

class MyApplicationCellTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
