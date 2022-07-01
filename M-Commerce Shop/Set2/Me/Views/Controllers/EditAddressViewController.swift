//
//  EditAddressViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit

class EditAddressViewController: UIViewController {
    
    @IBOutlet weak var backButton: CircleButtonShadowView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    
    var viewModel: AddAddresseViewModel!
    var selectedAddress: Address?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backButton.setTitle("", for: .normal)

        countryTextField.text = selectedAddress?.country
        cityTextField.text = selectedAddress?.city
        address1TextField.text = selectedAddress?.address1
        address2TextField.text = selectedAddress?.address2
        
        viewModel = AddAddresseViewModel()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backToAddresses(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func saveChangesToAddress(_ sender: UIButton) {
        let address = Address(country: countryTextField.text, city: cityTextField.text, address1: address1TextField.text, address2: address2TextField.text)
        
        viewModel.addAddress(address: address)
        
        Helper.displayMessage(message: "Suuccessfully Edited the New Address", messageError: false)
        self.dismiss(animated: true)
    }
}
