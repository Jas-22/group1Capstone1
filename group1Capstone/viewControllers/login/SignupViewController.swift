//
//  SignupViewController.swift
//  group1-capstone-project
//
//  Created by user207250 on 8/5/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class SignupViewController: UIViewController {

    @IBOutlet var FirstNameTextField: UITextField!
    
    
    @IBOutlet var LastNameTextField: UITextField!
    
    
    @IBOutlet var EmailTextField: UITextField!
    
    
    @IBOutlet var PasswordTextField: UITextField!
    
    
    @IBOutlet var SignupButton: UIButton!
    @IBOutlet var ErrorLabel: UILabel!
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        setupElements()
    }
    
    func setupElements(){
        ErrorLabel.alpha = 0
        
        Utilities.styleTextField(FirstNameTextField)
        Utilities.styleTextField(LastNameTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(SignupButton)
 
    }
    
    func validateFields() -> String? {
           
           // Check that all fields are filled in
           if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               
               return "Please fill in all fields."
           }
           
           // Check if the password is secure
           let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if Utilities.isPasswordValid(cleanedPassword) == false {
               // Password isn't secure enough
               return "Please make sure your password is at least 8 characters, contains a special character and a number."
           }
           
           return nil
       }
    
    func showError(_ message:String){
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    @IBAction func SignupTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
           showError(error!)
        }
        else{
            //create data
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                                                
            let passWord = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: email, password: passWord) { (result, err) in
                
                if err != nil{
                    self.showError("Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName,"uid":result!.user.uid]){(error) in
                        
                        if error != nil {
                            self.showError("Error while saving user data")
                        }
                    }
                    self.transitionToHome()
            }
        }
           
      }

    }
    func transitionToHome() {
        // add core data saving the logged in and other user information
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = mainStoryboard.instantiateViewController(identifier: "TabBar") as? UITabBarController

        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
    
    

