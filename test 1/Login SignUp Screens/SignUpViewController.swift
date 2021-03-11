//
//  SignUpViewController.swift
//  LoginTestApp
//
//  Created by students on 2/16/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()

    }
    
    func setUpElements() {
        
        // hide the error label
        errorLabel.alpha = 0
        
        // style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    func validateFields() -> String? {
        
        // check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        // check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password is not secure enough
            return "Password must include at least 8 characters, a special character, and a number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // there is something wrong with fields, show error message
            showError(error!)
        }
        else {
        
            // create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
              
                // check for errors
                if err != nil {
                    // there was an error creating the user
                    let errdesc=err!.localizedDescription
                    print (errdesc)
                    self.showError("Error creating user."+errdesc)
                }
                else {
                    
                    // user was created successfully, now store first and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                    
                        print(type(of: error))
                        
                        if error != nil {
                            // Show error message.
                            let errmsg=error!.localizedDescription
                            self.showError("Error saving user data."+errmsg)
                        }
                    }
                    
                    let defaults = UserDefaults.standard
                    defaults.set(email, forKey: "email")
                    defaults.set(password, forKey: "password")

                    // transition to the home screen
                    self.transitionToHome()
                }
            }
            
        }
    }
   
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TrailsTableViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }

}
