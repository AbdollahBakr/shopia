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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressesCollectionView.delegate = self
        addressesCollectionView.dataSource = self
        
        // Register CartItemCollectionViewCell from XIB
        let addressNipCell = UINib(nibName: "AddressCollectionViewCell", bundle: nil)
        addressesCollectionView.register(addressNipCell, forCellWithReuseIdentifier: AddressCollectionViewCell.identifier)
        
        backButton.setTitle("", for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backToSettings(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}


extension AddressesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  AddressCollectionViewCell.identifier, for: indexPath) as? AddressCollectionViewCell else { return AddressCollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = width/3
        
        return CGSize(width: width, height: height)
    }
    
    
}