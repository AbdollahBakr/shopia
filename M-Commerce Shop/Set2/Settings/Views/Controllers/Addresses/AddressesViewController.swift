//
//  AddressesViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit

class AddressesViewController: UIViewController {

    @IBOutlet weak var addressesCollectionView: UICollectionView!
    @IBOutlet weak var backButton: CircleButtonShadowView!
    
    var viewModel: AddressesViewModel!
    var addresses: [Address]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressesCollectionView.delegate = self
        addressesCollectionView.dataSource = self
        
        // Register CartItemCollectionViewCell from XIB
        let addressNipCell = UINib(nibName: "AddressCollectionViewCell", bundle: nil)
        addressesCollectionView.register(addressNipCell, forCellWithReuseIdentifier: AddressCollectionViewCell.identifier)
        
        // Remove title from back button
        backButton.setTitle("", for: .normal)
        

        // Get Addresses From API
        viewModel = AddressesViewModel()
        viewModel.bindAddressestoVC = { [weak self] in
            DispatchQueue.main.async {
                self?.addresses = self?.viewModel.addresses
                self?.addressesCollectionView.reloadData()
            }
        }
        
        viewModel.getAddresses()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAddresses()
        addressesCollectionView.reloadData()
        print("will appear")
    }
    @IBAction func addNewAddressForm(_ sender: UIButton) {
        guard let addNewAddressesVC = storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") else { return }
        presentVC(vc: addNewAddressesVC, animated: true)
    }
    
    @IBAction func backToSettings(_ sender: UIButton) {
        self.dismiss(animated: true)
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


extension AddressesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  AddressCollectionViewCell.identifier, for: indexPath) as? AddressCollectionViewCell else { return AddressCollectionViewCell()}
        
        // Set cell delegate for delete button
        cell.delegate = self
        
        cell.address = addresses?[indexPath.item]

        cell.countryLabel.text = cell.address?.country
        cell.cityLabel.text = cell.address?.city
        cell.address1Label.text = cell.address?.address1
        cell.address2Label.text = cell.address?.address2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = width/3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let editAddressesVC = storyboard?.instantiateViewController(withIdentifier: "EditAddressViewController") as? EditAddressViewController else { return }
        
        editAddressesVC.selectedAddress = addresses?[indexPath.item]
        
        presentVC(vc: editAddressesVC, animated: true)
    }
}


extension AddressesViewController: AddressesCellDelegate {
    func didTapDeleteButton() {
        
        // Delete associated address
        viewModel.deleteAddress()
        
        // Get Addresses and refresh view
        addresses = [Address]()
        addressesCollectionView.reloadData()
    }
}
