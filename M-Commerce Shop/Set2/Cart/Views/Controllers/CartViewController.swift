//
//  CartViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 25/06/2022.
//

import UIKit
import Kingfisher

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartItemsCollectionView: UICollectionView!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var viewModel: CartViewModel!
    var draftOrder: DraftOrder?
    var cartItems: [Edge]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Loading Indicator
        Helper.hudProgress()
        // Set collection view delegate & data source
        cartItemsCollectionView.delegate = self
        cartItemsCollectionView.dataSource = self
        
        // Register CartItemCollectionViewCell from XIB
        let cartItemsNipCell = UINib(nibName: "CartCollectionViewCell", bundle: nil)
        cartItemsCollectionView.register(cartItemsNipCell, forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        
        // Get Cart Items From API
        viewModel = CartViewModel()
        viewModel.bindCartItemstoVC = { [weak self] in
            DispatchQueue.main.async {
                self?.cartItems = self?.viewModel.draftOrder?.lineItems?.edges
                self?.draftOrder = self?.viewModel.draftOrder
                self?.populateTotalSection()
                self?.cartItemsCollectionView.reloadData()
                Helper.dismissHud()
            }
        }
        
        viewModel.getCartItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCartItems()
    }
    
    func populateTotalSection(){
        totalLabel.text = viewModel.formatPrice(value: draftOrder?.totalPrice)
        shippingLabel.text = viewModel.formatPrice(value: draftOrder?.totalShippingPrice)
        taxLabel.text = viewModel.formatPrice(value: draftOrder?.totalTax)
    }
}


extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as? CartCollectionViewCell else { return CartCollectionViewCell()}
        
        // Configure Cell with line item
        cell.delegate = self
        cell.cartItem = cartItems?[indexPath.item]
        cell.itemNameLabel.text = cell.cartItem?.node?.name
        cell.itemPriceLabel.text = viewModel.formatPrice(value: cell.cartItem?.node?.originalUnitPrice)
        cell.itemCountLabel.text = cell.cartItem?.node?.quantity?.description
        let url = URL(string: cell.cartItem?.node?.image?.url ?? "")
        cell.cartItemImageView.kf.setImage(with: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = width/2
        
        return CGSize(width: width, height: height)
    }
}


extension CartViewController: CartCellDelegate {
    func didTapDeleteButton(item: Edge) {
        
        if let index = cartItems?.firstIndex(where: {$0 == item}) {
            print("Item Deleted: \(item) ad index \(index)")
            cartItems?.remove(at: index)
        }
        cartItemsCollectionView.reloadData()
        
    }
}
