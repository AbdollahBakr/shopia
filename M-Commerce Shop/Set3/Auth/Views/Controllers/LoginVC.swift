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
    var currentCustomer: CustomerItem?
    var authViewModel: AuthViewModel?
    let network = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCustomer = CustomerItem()
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
                
                let storyboard = UIStoryboard(name: "Wishlist", bundle: nil)
                let wishlistVC =
                storyboard.instantiateViewController(withIdentifier: "WishlistViewController") as? WishlistViewController
                guard let wishlistVC = wishlistVC else {return}
                wishlistVC.modalPresentationStyle = .fullScreen
                self.present(wishlistVC.self, animated: true)
                
                Helper.displayMessage(message: "Login Success", messageError: false)
                
                guard let customer = customer else {
                    return
                }
                Helper.currentUserID =  (customer.id)!
            }else if customer?.email == nil && customer?.multipass_identifier == nil{
                Helper.displayMessage(message: "Wrong E-mail or Password", messageError: true)
            }
        })
        
    }
    
    
    @IBAction func signupBtn(_ sender: UIButton) {
        
        let newVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "SignUpVC")
        newVC.modalPresentationStyle = .fullScreen
//        dismiss(animated: true) { [weak self] in
//            self?.present(newVC, animated: true)
//        }
        present(newVC, animated: true)
    }
    
    @IBAction func backBtnToSignup(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}

