//
//  PaymentViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 03/07/2022.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var offlineSwitch: UISwitch!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var viewModel: PaymentViewModel!
    var amountToPay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = PaymentViewModel()
        
        totalAmountLabel.text = amountToPay
    }
    

    @IBAction func selectPayment(_ sender: Any) {
        let segmentIndex = paymentSegmentedControl.selectedSegmentIndex
       
        switch segmentIndex {
        case 0:
            print("Apple Pay")
        case 1:
            print("Visa")
        case 2:
            print("PayPal")
        default:
            print("Not segment selected")
        }
    }
    @IBAction func selectPayOffline(_ sender: Any) {
        if offlineSwitch.isOn {
            print("Cash On Delivery")
            paymentSegmentedControl.isEnabled = false
        } else
        {
            print("Pay online")
            paymentSegmentedControl.isEnabled = true
        }
    }
    @IBAction func placeOrder(_ sender: Any) {
        if offlineSwitch.isOn {
            viewModel.payCashOnDelivery()
            Helper.displayMessage(message: "Checkouts are not available for this store", messageError: true)
        } else {
            Helper.displayMessage(message: "Checkouts are not available for this store", messageError: true)
        }
    }
    
}
