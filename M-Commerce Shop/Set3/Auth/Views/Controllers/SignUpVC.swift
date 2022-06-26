//
//  SignUpVC.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 25.06.22.
//

import UIKit

class SignUpVC: UIViewController {

   
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var signupUserData : SignupUserData?
    var authViewModel : AuthViewModel?
    var customer : Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customer = Customer(email: "", first_name: "", last_name: "", multipass_identifier: "", send_email_invite: true)
        
        signupUserData = SignupUserData(customer: customer ?? Customer(email: "", first_name: "", last_name: "", multipass_identifier: "", send_email_invite: true))
   
        let network = NetworkManager.shared
        authViewModel = AuthViewModel(networkservice: network)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signupBtn(_ sender: RoundedShodowButton) {
        Helper.displayMessage(message: "plz fill data", messageError: false)
        customer?.first_name = firstNameTextField.text ?? ""
        customer?.last_name = lastNameTextField.text ?? ""
        customer?.email = emailTextField.text ?? ""
        customer?.multipass_identifier = passwordTextField.text ?? ""
        guard let customer = customer else {return}
        signupUserData?.customer = customer
        guard let signupUserData = signupUserData else {
            return
        }
        authViewModel?.createUser(signupUserData: signupUserData)
        
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        
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
