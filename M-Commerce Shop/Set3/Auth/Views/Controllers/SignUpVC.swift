//
//  SignUpVC.swift
//  M-Commerce Shop
//
//  Created by Mina Kamal on 25.06.22.
//

import UIKit

class SignUpVC: UIViewController {

    @IBAction func firstNameTextField(_ sender: UITextField) {
    }
    @IBAction func lastNameTextField(_ sender: UITextField) {
    }
    @IBAction func emailTextField(_ sender: UITextField) {
    }
    @IBAction func passwordTextField(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var network = NetworkManager.shared
    
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signupBtn(_ sender: RoundedShodowButton) {
        Helper.displayMessage(message: "plz fill data", messageError: true)
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
