//
//  WishlistViewController.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 29.06.22.
//

import UIKit

class WishlistViewController: UIViewController {

    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        wishlistCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        // Register WishlistCollectionViewCell from XIB
        let cartItemsNipCell = UINib(nibName: "WishlistCollectionViewCell", bundle: nil)
        wishlistCollectionView.register(cartItemsNipCell, forCellWithReuseIdentifier: WishlistCollectionViewCell.identifier)
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




extension WishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.identifier, for: indexPath) as? WishlistCollectionViewCell else { return WishlistCollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 300)
    }
}


