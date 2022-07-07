//
//  MeViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 27/06/2022.
//

import UIKit
import SwiftUI

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
    var coreDataManager: CoreDataManager!
    
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
        
        // Initialize CoreDataManager for wishlist
        coreDataManager = CoreDataManager.shared
    }
    
    func loadViewData(){
        welcomeLabel.text = ["Welcome,", customer?.firstName].compactMap{ $0 }
            .joined(separator: " ")
        
        // If not signed in
        if !Helper.isUserLoggedIn() {
            // Display not-registered relevant data
            welcomeLabel.text = "You're not logged in"
            signInButton.isHidden = false
            signUpButton.isHidden = false
            
            // Hide registered-relevant data
            settingsButton.isHidden = true
            cartButton.isHidden = true
            ordersLabel.isHidden = true
            firstOrderStackView.superview?.isHidden = true
            secondOrderStackView.superview?.isHidden = true
            viewOrdersButton.isHidden = true
            wishlistLabel.isHidden = true
            wishlistStackView.isHidden = true
            viewFavButton.isHidden = true
        } else {
            // Orders
            ordersLabel.text = "No orders placed yet"
            
            // Wishlist
            let wishlist = coreDataManager.getWishlistProducts()
            if wishlist.count == 0 {
                wishlistLabel.text = "No favorites were added"
                wishlistStackView.isHidden = true
                viewFavButton.isHidden = true
            } else {
                // Populate wishlist
                for (index, favorite) in wishlist.enumerated() {
                    (wishlistStackView.arrangedSubviews[index] as? UIImageView)?.kf.setImage(with: URL(string: favorite.image ?? ""))
                    if index == 3 {
                        break
                    }
                }
                print(wishlist)
            }
            
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
    @IBAction func goToCart(_ sender: CircleButtonShadowView) {
        
        guard let cartVC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(identifier: "CartViewController") as? CartViewController else {return}
        present(cartVC, animated: true)
    }
    
    @IBAction func goToSettings(_ sender: CircleButtonShadowView) {
        guard let settingsVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(identifier: "SettingsViewController") as? SettingsViewController else {return}
        presentVC(vc: settingsVC, animated: true)
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
        guard let signInVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        presentVC(vc: signInVC, animated: true)
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        guard let signUpVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else {return}
        presentVC(vc: signUpVC, animated: true)
    }
    @IBAction func viewMoreWishlist(_ sender: Any) {
        guard let wishlistVC = UIStoryboard(name: "Wishlist", bundle: nil).instantiateViewController(withIdentifier: "WishlistViewController") as? WishlistViewController else {return}
        presentVC(vc: wishlistVC, animated: true)
    }
}
