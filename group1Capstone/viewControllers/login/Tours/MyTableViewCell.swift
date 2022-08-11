//
//  MyTableViewCell.swift
//  TableView7.1
//
//  Created by Oscar Pinzon
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myLocationImage: UIImageView!
    
    @IBOutlet weak var myLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
