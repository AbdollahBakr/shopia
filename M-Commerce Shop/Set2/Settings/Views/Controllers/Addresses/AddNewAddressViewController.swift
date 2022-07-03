//
//  AddNewAddressViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit
import CountryPickerView

class AddNewAddressViewController: UIViewController {
    
    @IBOutlet weak var backButton: CircleButtonShadowView!
    
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var address1Field: UITextField!
    @IBOutlet weak var address2Field: UITextField!
    
    var viewModel: AddAddresseViewModel!
    var address: Address?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = AddAddresseViewModel()
        backButton.setTitle("", for: .normal)
        
        // Setup country picker
        let countryPicker = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        countryPicker.delegate = self
        countryPicker.showPhoneCodeInView = false
        countryPicker.showCountryCodeInView = false
//        countryPicker.selectedCountry.flag
//        countryPicker.selectedCountry = Country(name: "Egypt", code: "", phoneCode: "")
        countryField.rightView = countryPicker
        countryField.rightViewMode = .always
        // Hide cursor
        countryField.tintColor = UIColor.clear
        // Hide keyboard
        countryField.resignFirstResponder()
        countryField.placeholder = "Please, select a country"
//        countryField.ed
    }
    

    @IBAction func backToAddresses(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func saveNewAddress(_ sender: UIButton) {
        
        let address = Address(country: countryField.text, city: cityField.text, address1: address1Field.text, address2: address2Field.text)
        
        viewModel.addAddress(address: address)
        
        Helper.displayMessage(message: "Suuccessfully Saved the New Address", messageError: false)
        self.dismiss(animated: true)
    }
}


extension AddNewAddressViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        
        countryField.text = country.name
    }
    
    
}
