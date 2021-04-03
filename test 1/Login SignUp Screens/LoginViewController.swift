//
//  LoginViewController.swift
//  LoginTestApp
//
//  Created by students on 2/16/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
        let defaults = UserDefaults.standard

            if (defaults.string(forKey: "email") != nil) {
                let email = defaults.string(forKey: "email")
                print("email:"+email!)
                emailTextField.text = email
             }
            
            if (defaults.string(forKey: "password") != nil) {
                let password = defaults.string(forKey: "password")
                print("password:"+password!)
                passwordTextField.text = password
             }

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard

        if (defaults.string(forKey: "email") != nil) {
            let email=defaults.string(forKey: "email")
            print("email:"+email!)
            emailTextField.text=email
         }
        
        if (defaults.string(forKey: "password") != nil) {
            let password=defaults.string(forKey: "password")
            print("password:"+password!)
            passwordTextField.text=password
         }

    }
    
    func setUpElements() {
        
        // hide error label
        errorLabel.alpha = 0
        
        // style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // validate the text fields
        let error = validateFields()
        
        if error != nil {
            
            // there is something wrong with fields, show error message
            showError(error!)
        }
        else {
        
        // create cleaned text fields
            
           let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
        
        // login the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                // couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                // successful sign in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                
                let defaults = UserDefaults.standard
                defaults.set(email, forKey: "email")
                defaults.set(password, forKey: "password")
            }
        }
    }
    }
    
    func validateFields() -> String? {
        
        // check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    func transitionToHome() {
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TrailsTableViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        

    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
