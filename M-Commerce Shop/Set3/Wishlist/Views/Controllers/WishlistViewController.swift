//
//  WishlistViewController.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 29.06.22.
//

import UIKit
import Kingfisher

class WishlistViewController: UIViewController {

    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    @IBOutlet weak var noFavoriteView: UIView!
    @IBOutlet weak var logInView: UIView!
    var wishlistViewModel: WishlistViewModel?
    var localDataSource: CoreDataManager?
    var favProducts: [ProductSavedModel]?
    
    override func viewWillAppear(_ animated: Bool) {
        
//        Helper.logoutUser()
        if Helper.isUserLoggedIn() {
            
            localDataSource = CoreDataManager.shared
            guard let localDataSource = localDataSource else {
                return
            }
            wishlistViewModel = WishlistViewModel(localDataSource: localDataSource)
            favProducts = wishlistViewModel?.getfavProducts()
            
            if  self.favProducts?.isEmpty ?? true{
                noFavoriteView.isHidden = false
                logInView.isHidden = true
                wishlistCollectionView.isHidden = true
                
            }else {
                noFavoriteView.isHidden = true
                logInView.isHidden = true
                wishlistCollectionView.isHidden = false
                self.wishlistCollectionView.reloadData()
            }
        }else{
            favProducts = []
            if  self.favProducts?.isEmpty ?? true{
                noFavoriteView.isHidden = true
                wishlistCollectionView.isHidden = true
                logInView.isHidden = false
                }
            }
        }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        wishlistCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        // Register WishlistCollectionViewCell from XIB
        let cartItemsNipCell = UINib(nibName: "WishlistCollectionViewCell", bundle: nil)
        wishlistCollectionView.register(cartItemsNipCell, forCellWithReuseIdentifier: WishlistCollectionViewCell.identifier)
    }
    
    
    @IBAction func logInBtn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let loginVC =
        storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        guard let loginVC = loginVC else {return}
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    @IBAction func backBtn(_ sender: CircleButtonShadowView) {
        dismiss(animated: true)
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
        return favProducts?.count ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishlistCollectionViewCell", for: indexPath) as? WishlistCollectionViewCell else { return UICollectionViewCell()}
        cell.nameProduct.text = favProducts?[indexPath.row].title
        cell.priceProduct.text = favProducts?[indexPath.row].price
       
        let url = URL(string: "\(favProducts?[indexPath.row].image ?? "")")
        let processor = DownsamplingImageProcessor(size: (self.wishlistCollectionView.frame.size))
        |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.imageProduct.kf.indicatorType = .activity
        cell.imageProduct.kf.setImage(
            with: url,
            placeholder: UIImage(named: "football"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        
        guard let wishlistViewModel = wishlistViewModel else {return UICollectionViewCell()}
        cell.setData(wishlistViewModel: wishlistViewModel, productID: favProducts?[indexPath.row].id ?? "", wishlistVC: self, indexPath: indexPath.row)

//        cell.imageProduct.image = favProducts?[indexPath.row].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (collectionView.frame.size.height\4)
//        let width = (collectionView.frame.size.width\2)
        
        let leftAndRightPaddings: CGFloat = 10.0
                let numberOfItemsPerRow: CGFloat = 2.0
            
                let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        let height = (collectionView.frame.height-leftAndRightPaddings)/numberOfItemsPerRow - 35
                return CGSize(width: width, height: height) // You can change width and height here as pr your requirement
//        return CGSize(width: width, height: height)
    }
    
    
    func updateWishlistViewCells(indexpath: Int){
        favProducts?.remove(at: indexpath)
        wishlistCollectionView.reloadData()
        if favProducts?.count == 0 {
            wishlistCollectionView.isHidden = true
            noFavoriteView.isHidden = false
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let productDeatailsVC =
        storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
        guard let productDeatailsVC = productDeatailsVC else {return}
        productDeatailsVC.modalPresentationStyle = .fullScreen
        productDeatailsVC.modalTransitionStyle = .flipHorizontal
        productDeatailsVC.productID = Int(self.favProducts?[indexPath.row].id ?? "7358110105771")
        present(productDeatailsVC, animated: true) {

        }
        
    }
}


