//
//  WebViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 07/07/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var adsWebView: WKWebView!
    
    var urlStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Initialize the web view url
        guard let webUrl = URL(string: urlStr) else { return }
        
        // Request the initialized url
        let urlRequest = URLRequest(url: webUrl)
        
        // Load the web view
        adsWebView.load(urlRequest)
    }
    


}
