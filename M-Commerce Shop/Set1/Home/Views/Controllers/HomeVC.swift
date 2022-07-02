//
//  HomeVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 26/06/2022.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Declare the serachBar & Menu Button In Nav Bar
    let menuButton           = UIButton(type: .custom)
    
    // Instance For Implementing Composotional Layout Logic
    var compostionalLayoutInstance: ComposotionalLayout!
    
    // Has instance from ViewModel to Run logic/Func from it
    var viewModelInstance : HomeViewModel?
    
    
    var categoriesArray = [SmartCollections]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        
        // CollectionView Header
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil),forSupplementaryViewOfKind: "header",withReuseIdentifier:"HeaderView")
        collectionView.delegate   = self
        collectionView.dataSource = self
        
        compostionalLayoutInstance = ComposotionalLayout()
        collectionView.collectionViewLayout = compostionalLayoutInstance.createcompositionalLayout()
        searchBar.delegate = self
        DismissSearchBar()
        listSportsData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavBar()
    }
 
    func listSportsData() {

        viewModelInstance = HomeViewModel()
        self.viewModelInstance?.listCategoriesData()
        viewModelInstance?.bindCategoriesToHomeView = { [weak self] in
            DispatchQueue.main.async {
               // Helper.dismissAnimation()
                //self?.collectionView.isHidden = false
                self?.categoriesArray = self?.viewModelInstance?.categoriesArray ?? []
                //self?.filteredSportsArr = (self?.sportsArray)!
                self?.collectionView.reloadData()
            }
        }
        
    }
   
}
extension HomeVC :UISearchBarDelegate{
    // MARK: - <SearchBar>
    fileprivate func configureNavBar() {
        
 
        navigationController?.navigationBar.sizeToFit()
        
        // Left Button Items
        menuButton.setImage(UIImage (named: "menu"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        menuButton.backgroundColor = UIColor(named:"GreyColor")
        menuButton.layer.cornerRadius = menuButton.frame.width / 2
        menuButton.layer.shadowOpacity = 0.4
        menuButton.layer.shadowOffset = CGSize.zero
        menuButton.layer.shadowRadius = 3
        let menuButtonItem = UIBarButtonItem(customView: menuButton)
        //button.addTarget(target, action: nil, for: .touchUpInside)
        self.navigationItem.leftBarButtonItems  = [menuButtonItem]
        
        // Right Button Items
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage (named: "Heart"), for: .normal)
        heartButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        heartButton.backgroundColor = UIColor(named:"GreyColor")
        heartButton.layer.cornerRadius = heartButton.frame.width / 2
        heartButton.layer.shadowOpacity = 0.4
        heartButton.layer.shadowOffset = CGSize.zero
        heartButton.layer.shadowRadius = 3
        //button.addTarget(target, action: nil, for: .touchUpInside)
        
        let cartButton = UIButton(type: .custom)
        cartButton.setImage(UIImage (named: "Cart"), for: .normal)
        cartButton.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        cartButton.backgroundColor = UIColor(named:"GreyColor")
        cartButton.layer.cornerRadius = cartButton.frame.width / 2
        cartButton.layer.shadowOpacity = 0.4
        cartButton.layer.shadowOffset = CGSize.zero
        cartButton.layer.shadowRadius = 3
        
        let heartButtonItem = UIBarButtonItem(customView: heartButton)
        let cartButtonItem  = UIBarButtonItem(customView: cartButton)
        self.navigationItem.rightBarButtonItems = [cartButtonItem,heartButtonItem]
        
      
    }
    
    func DismissSearchBar() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
}

extension HomeVC :UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        
        case 0:
            return categoriesArray.count
            
//        case 1:
//            return leageDetailsData?.count ?? 1
//
//        case 2:
//            return leagueTeams?.count      ?? 1
            
        default:
            print("Error")
            return 0
        }
        
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        
        case 0:
            guard let firstView = self.collectionView.dequeueReusableSupplementaryView(ofKind: compostionalLayoutInstance.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            
            firstView.headerLabel.text =  "Choose Brand"
            return firstView
            
//        case 1:
//            guard let secondView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
//                return UICollectionReusableView()
//            }
//
//            secondView.headerLabel.text =  "Latest Results"
//            secondView.headerLabel.textAlignment = .left
//            return secondView
//
//        case 2:
//
//            guard let thirdView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
//                return UICollectionReusableView()
//            }
//
//            thirdView.headerLabel.text =  "Teams"
//            thirdView.headerLabel.textAlignment = .left
//            return thirdView
            
            
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch indexPath.section {
        
        case 0:
            
            guard let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as? CategoriesCell else {
                return UICollectionViewCell()
            }
            
            firstCell.categoryNameLabel.text = categoriesArray[indexPath.row].title
            
            if let url = URL(string: categoriesArray[indexPath.row].image?.src ?? "") {
                //let placeholder = UIImage(named: "placeholder")
                let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
                firstCell.categoryImageView.kf.indicatorType = .activity
                firstCell.categoryImageView.kf.setImage(with: url,placeholder: nil,options: options)
            
            
            }
            return firstCell
//        case 1:
//
//            guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacingTeamsCell", for: indexPath) as? FacingTeamsCell else {
//                return UICollectionViewCell()
//            }
//
//            secondCell.configureCell(teamData: self.leageDetailsData?[indexPath.row])
//            return secondCell
//
//        case 2:
//
//            guard let thirdCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as? TeamsCell else {
//                return UICollectionViewCell()
//            }
//
//            thirdCell.configureCell(leagueDetails: leagueTeams?[indexPath.row])
//            return thirdCell
            
        default:
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
//        case 2:
//            let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
//            guard let vc         = storyboard.instantiateViewController(withIdentifier:"TeamDetailsVC") as? TeamDetailsVC else {return}
//
//            vc.name  = self.leagueTeams?[indexPath.row].strTeam
//            vc.image = self.leagueTeams?[indexPath.row].strTeamBadge
//
//            vc.modalPresentationStyle = .fullScreen
//
//            self.present(vc, animated: true)
        default:
            print("error")
        }
    }
}

