//
//  LoginVC.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal Mac on 23.06.22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var currentCustomer: Customer?
    var authViewModel: AuthViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCustomer = Customer()
        let network = NetworkManager.shared
        authViewModel = AuthViewModel(networkservice: network)
    }

    @IBAction func loginBtn(_ sender: RoundedShodowButton) {
        currentCustomer?.email = emailTextField.text
        currentCustomer?.multipass_identifier = passwordTextField.text
        guard let currentCustomer = currentCustomer else {
            return
        }
        authViewModel?.loginUser(currentCustomer: currentCustomer, completionHandler: { customer in
            if customer != nil {
                Helper.displayMessage(message: "Login Success", messageError: false)
            }else{
                Helper.displayMessage(message: "Wrong Username or Password", messageError: true)
            }
        })
        
    }
    
    
    @IBAction func signupBtn(_ sender: UIButton) {
        
        let newVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "SignUpVC")
        newVC.modalPresentationStyle = .fullScreen
        dismiss(animated: true) { [weak self] in
            self?.present(newVC, animated: true)
        }
    }
    
    @IBAction func backBtnToSignup(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}

