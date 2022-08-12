//
//  ReviewsViewCell.swift
//  group1-capstone-project
//
//  Created by Jose Alberto Martinez Pineda on 2022-08-07.
//

import UIKit

class ReviewsViewCell: UITableViewCell {

    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userThing: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!

    @IBOutlet weak var star4: UIImageView!
    
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var commentThing: UITextView!
    
    @IBOutlet weak var dateComment: UILabel!
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
