//
//  SignUpVC.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 25.06.22.
//

import UIKit
import SwiftMessages

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var signupUserData : SignupUserData?
    var authViewModel : AuthViewModel?
    var customer : CustomerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let network = NetworkManager.shared
        authViewModel = AuthViewModel(networkservice: network)
        customer = CustomerModel(email: "", first_name: "", last_name: "", multipass_identifier: "", send_email_invite: true)
    
    }
    
    
    @IBAction func signupBtn(_ sender: RoundedShodowButton) {
        
        let firstName  = firstNameTextField.text ?? ""
        let lastName   = lastNameTextField.text ?? ""
        let password   = passwordTextField.text ?? ""
        let email      = emailTextField.text ?? ""
        
        // Validate the text fields
        
        if ( firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty ) {
            Helper.displayMessage(message: "Empty fields", messageError: true)
        }else {
             if firstName.count < 3 {
                Helper.displayMessage(message: "First Name must be greater than 3 characters", messageError: true)
            } else if lastName.count < 3{
                Helper.displayMessage(message: "Last Name must be greater than 3 characters", messageError: true)
            } else if isValidEmail(email) == false {
                Helper.displayMessage(message: "Please enter a valid email address", messageError: true)
            } else if password.count < 8 {
                Helper.displayMessage(message: "Password must be greater than 8 characters", messageError: true)
            } else {
                customer?.first_name            = firstName
                customer?.last_name             = lastName
                customer?.multipass_identifier  = password
                customer?.email                 = email
                guard let customer = customer else {
                    return
                }
                authViewModel?.createUser(customer: customer, completionHnadler: { customerDictionary, signupError in
                    if customerDictionary != nil || signupError != nil{
                        if customerDictionary != nil{
                            Helper.displayMessage(message: "Signup Successfully", messageError: false)
                        }else{
                            Helper.displayMessage(message: "email \(signupError?.errors["email"]?.first ?? "")", messageError: true)
                        }
                    }else{
                        Helper.displayMessage(message: "Something went wrong!!", messageError: true)
                    }
                })
                
            }
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let newVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "LoginVC")
        newVC.modalPresentationStyle = .fullScreen
        dismiss(animated: true) { [weak self] in
            self?.present(newVC, animated: true)
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
