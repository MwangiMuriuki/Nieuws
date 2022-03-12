//
//  FullStoryVC.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 28/02/2022.
//

import UIKit
import WebKit

class FullStoryVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var sourceUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: sourceUrl!)
        self.webView.load(URLRequest(url: url!))
        webView.allowsLinkPreview = true
        webView.allowsBackForwardNavigationGestures = true
        
    }
    

    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareTapped(_ sender: Any) {
    }
}
