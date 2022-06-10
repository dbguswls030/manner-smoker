//
//  HeaderMyPageTableCell.swift
//  Manner-Smoker
//
//  Created by RooZin on 2022/05/19.
//

import UIKit

class HeaderMyPageTableCell: UITableViewCell {

    
    @IBOutlet var title: UILabel!
    @IBOutlet var smokeTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
