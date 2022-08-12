//
//  CommentViewController.swift
//  group1-capstone-project
//
//  Created by user206772 on 8/7/22.
//

import UIKit

class CommentViewController: UIViewController {

    
    var thing: Thing?
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var ratingStackView: RatingController!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var commentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        cancelButton.layer.borderColor = UIColor.systemBlue.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 5
        
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.layer.borderWidth = 1
        addButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true)
    }
    @IBAction func addReview(_ sender: Any) {
        let comment = Comment()
        comment.comment = commentText.text
        comment.idUser = "1"
        comment.rate = Double(ratingStackView.starsRating)
        if comment.rate > 0 && comment.comment.count > 0 {
        addComment(idThing: thing!.id, comment: comment)
            
            let alert = UIAlertController(title: "Saved", message: " ", preferredStyle: .alert)
            
            //Add textfield
            
            //alert.message = "You should rate and comment."
            let image = UIImage(systemName: "checkmark.circle")
            
            alert.setValue(image, forKey: "image")
            
            var imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
            imageView.image = image
            
            alert.view.addSubview(imageView)
            //Create OK button
            let acceptAction = UIAlertAction(title: "Ok", style: .default) {(_) in
            
                
                
                self.dismiss(animated: true)
                }
            
            //we add action to alert
            alert.addAction(acceptAction)
 
            //show alert
            present(alert, animated: true, completion: nil)
            
        } else {
             
            let alert = UIAlertController(title: "Error", message: "write review", preferredStyle: .alert)
            
            //Add textfield
            
            alert.message = "You must rate and comment."
             
            
            
            //Create OK button
            let acceptAction = UIAlertAction(title: "Ok", style: .default) {(_) in
                     
      
            
                }
            
            //we add action to alert
            alert.addAction(acceptAction)
 
            //show alert
            present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
