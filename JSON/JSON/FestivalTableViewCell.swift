//
//  FestivalTableViewCell.swift
//  JSON
//
//  Created by Medi Assumani on 2/7/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class FestivalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
