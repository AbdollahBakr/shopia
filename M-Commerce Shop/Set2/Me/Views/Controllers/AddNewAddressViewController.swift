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
    
    @IBOutlet weak var saveAddressButton: RoundedButton!
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
        
        setupCountryPicker()
        
        // Setup required validation
//        saveAddressButton.isEnabled = false
//        cityField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        address1Field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//
//        textFieldDidChange(cityField)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if (sender.text) != nil {
            //Disable button
            saveAddressButton.isEnabled = false
            print("disable")
        } else {
            //Enable button
            saveAddressButton.isHidden = true
            print("enable")
        }
    }

    @IBAction func backToAddresses(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveNewAddress(_ sender: UIButton) {
        
        if let text = cityField.text, text.isEmpty {
            print("empty")
            Helper.displayMessage(message: "City field is required", messageError: true)
            showAlert(title: "Required", message: "You must provide a city")
        } else {
            // Create new address object from text fields
            let address = Address(country: countryField.text, city: cityField.text, address1: address1Field.text, address2: address2Field.text)
      
            // Append the address in the API
            viewModel.addAddress(address: address)
            
            Helper.displayMessage(message: "Suuccessfully Saved New Address", messageError: false)
        }
    }

    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// Country picker
extension AddNewAddressViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        
        countryField.text = country.name
    }
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        return ["EG", "SA", "US"].compactMap { countryPickerView.getCountryByCode($0) }
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Favorites"
    }
    
    func setupCountryPicker(){
        // Setup country picker
        let countryPicker = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.showPhoneCodeInView = false
        countryPicker.showCountryCodeInView = false

        countryField.rightView = countryPicker
        countryField.rightViewMode = .always
        // Hide cursor
        countryField.tintColor = UIColor.clear
        // Hide keyboard
        countryField.resignFirstResponder()
        // Placeholder based on the current user location country
        countryField.text = countryPicker.selectedCountry.name
    }
    
}
