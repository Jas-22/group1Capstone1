//
//  LoginViewController.swift
//  group1Capstone
//
//  Created by Jazz Stephan on 08/08/22.
//
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var SignupButton: UIButton!
    @IBOutlet var LoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroungImage = UIImageView(frame: UIScreen.main.bounds)
        backgroungImage.image = UIImage(named: "back")
        backgroungImage.contentMode = .scaleToFill
        view.insertSubview(backgroungImage, at: 0)
        
        // Do any additional setup after loading the view.
        setupElements()
        
    }
    func setupElements(){
      
        Utilities.styleFilledButton(SignupButton)
        Utilities.styleFilledButton(LoginButton)
        
        
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
