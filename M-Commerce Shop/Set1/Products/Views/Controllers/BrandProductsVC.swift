//
//  BrandProductsVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 03/07/2022.
//

import UIKit

class BrandProductsVC: UIViewController {
    
    @IBOutlet weak var brandNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIButton!
    /********************Variables***************/
    var viewModelInstance     : BrandProductsViewModel?
    var brandName             : String?
    var brandId               : Int?
    var brandProductsArray    = [ProductsResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let title = brandName else {return}
        brandNameLabel.text = title
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BrandProductsCell", bundle: nil), forCellWithReuseIdentifier: "BrandProductsCell")
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Helper.hudProgress()
        listBrands()
    }
    
    func listBrands() {
        viewModelInstance = BrandProductsViewModel()
        self.viewModelInstance?.listBrands(brandId: brandId ?? 0)
        viewModelInstance?.bindBrandProductsToProductsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                self?.brandProductsArray = self?.viewModelInstance?.brandProductsArray ?? []
                //self?.filteredSportsArr = (self?.sportsArray)!
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension BrandProductsVC :UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandProductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandProductsCell", for: indexPath) as? BrandProductsCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(brandProduct: brandProductsArray[indexPath.item])
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 300.0)
    }
    
    
}

