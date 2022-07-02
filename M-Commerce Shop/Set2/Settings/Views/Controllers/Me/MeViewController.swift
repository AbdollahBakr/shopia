//
//  MeViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 27/06/2022.
//

import UIKit

class MeViewController: UIViewController {

    // OUTLETS
    @IBOutlet weak var settingsButton: CircleButtonShadowView!
    @IBOutlet weak var cartButton: CircleButtonShadowView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var firstOrderStackView: UIStackView!
    @IBOutlet weak var secondOrderStackView: UIStackView!
    @IBOutlet weak var viewOrdersButton: RoundedButton!
    @IBOutlet weak var viewFavButton: RoundedButton!
    @IBOutlet weak var wishlistLabel: UILabel!
    @IBOutlet weak var wishlistStackView: UIStackView!
    @IBOutlet weak var signInButton: RoundedButton!
    @IBOutlet weak var signUpButton: RoundedButton!
    
    var viewModel: MeViewModel!
    var customer: Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove titles from settings and cart buttons
        settingsButton.setTitle("", for: .normal)
        cartButton.setTitle("", for: .normal)
        
        // Hide Sign in & Sign up buttons
        signInButton.isHidden = true
        signUpButton.isHidden = true
        
        // Get Current Customer From API
        Helper.hudProgress()
        viewModel = MeViewModel()
        viewModel.bindCustomertoVC = { [weak self] in
            DispatchQueue.main.async {
                self?.customer = self?.viewModel.currentCustomer
                self?.loadViewData()
                Helper.dismissHud()
            }
        }
        
        viewModel.getCurrentCustomer()
    }
    
    func loadViewData(){
        welcomeLabel.text = ["Welcome,", customer?.firstName].compactMap{ $0 }
            .joined(separator: " ")
        
        // If not signed in
        if customer == nil {
            // Display not-registered relevant data
            welcomeLabel.text = "You're not logged in"
            signInButton.isHidden = false
            signUpButton.isHidden = false
            
            // Hide registered-relevant data
            ordersLabel.isHidden = true
            firstOrderStackView.superview?.isHidden = true
            secondOrderStackView.superview?.isHidden = true
            viewOrdersButton.isHidden = true
            wishlistLabel.isHidden = true
            wishlistStackView.isHidden = true
            viewFavButton.isHidden = true
        }
        
        // If signed in
        if customer?.numberOfOrders == "0" {
            // Hide Orders elements
            firstOrderStackView.superview?.isHidden = true
            secondOrderStackView.superview?.isHidden = true
            viewOrdersButton.isHidden = true
        } else {
            // Populate orders data
        }
    }

}
