//
//  TableViewCell.swift
//  group1-capstone-project
//
//  Created by Jose Alberto Martinez Pineda on 2022-08-05.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageThing: UIImageView!
    @IBOutlet weak var titleThing: UILabel!
    @IBOutlet weak var rateThing: UILabel!
    @IBOutlet weak var categoryThing: UILabel!
    @IBOutlet weak var hourThing: UILabel!
    @IBOutlet weak var reviewThing: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillStars (HowManyStars stars: Int){
        
        switch stars {
        case 1:
            star1.image = UIImage(systemName: "star.fill")
        case 2:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
        case 3:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
        case 4:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.fill")
             
        case 5:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.fill")
            star5.image = UIImage(systemName: "star.fill")
        default:
            print("No valid star: \(stars)" )
        }
        
    }

}
