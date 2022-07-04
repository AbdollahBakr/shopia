//
//  CartViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 25/06/2022.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartItemsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartItemsCollectionView.delegate = self
        cartItemsCollectionView.dataSource = self
        
        // Register CartItemCollectionViewCell from XIB
        let cartItemsNipCell = UINib(nibName: "CartItemCollectionViewCell", bundle: nil)
        cartItemsCollectionView.register(cartItemsNipCell, forCellWithReuseIdentifier: CartItemCollectionViewCell.identifier)
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


extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.identifier, for: indexPath) as? CartItemCollectionViewCell else { return CartItemCollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = width/2
        
        return CGSize(width: width, height: height)
    }
}
<<<<<<< HEAD
=======

// Delegated functions
extension CartViewController: CartCellDelegate {
    
    // Update total price based on quantity change
    func didChangeItemQuantity(item: Edge, newValue: Int) {
        if let index = cartItems?.firstIndex(where: {$0 == item}) {
            print("Quantity changed: \(item) ad index \(index)")
            cartItems?[index].node?.quantity = newValue
            updateTotalPrice()
        }
    }
    
    func didTapDeleteButton(item: Edge) {
        
        // Alert
        let alert = UIAlertController(title: "Remove Address", message: "Are you sure?", preferredStyle: .alert)
        
        // Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Confirm
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            
            if let index = self.cartItems?.firstIndex(where: {$0 == item}) {
                print("Item Deleted: \(item) ad index \(index)")
                self.cartItems?.remove(at: index)
            }
            self.cartItemsCollectionView.reloadData()
            self.viewModel.updateCartItems(cartItems: self.cartItems ?? [Edge]())
            self.updateTotalPrice()
        }))
        
        // present alert
        self.present(alert, animated: true)
        
    }
}
>>>>>>> SMCT1-ResolveForcedConflicts
