//
//  SigninViewController.swift
//  group1Capstone
//
//  Created by Jazz Stephan on 08/08/22.
//

import UIKit
import FirebaseAuth

class SigninViewController: UIViewController {

    
    @IBOutlet var EmailTextField: UITextField!
    
    
    @IBOutlet var PasswordTextField: UITextField!
    
    
    @IBOutlet var LoginButton: UIButton!
    
    
    @IBOutlet var ErrorLabel: UILabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        setupElements()
    }
    func setupElements(){
        ErrorLabel.alpha = 0
        
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
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
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        // create cleaned data
        
        do{
           
            let user = User(context: context)
            user.loggedIn = true;
            try context.save()
        }
        catch{
            
        }
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                                            
        let passWord = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: passWord){(result,error) in
            
            if error != nil {
                self.ErrorLabel.text = error!.localizedDescription
                self.ErrorLabel.alpha = 1
            }
            else{
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let homeViewController = mainStoryboard.instantiateViewController(identifier: "TabBar") as? UITabBarController

                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
            
        }
    }
    

}
