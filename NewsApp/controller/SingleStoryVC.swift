//
//  SingleStoryVC.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 26/02/2022.
//

import UIKit

class SingleStoryVC: UIViewController {

    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleTime: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fullStory: UIButton!
    var newsData = NewsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }
    
    func loadData(){
        articleTitle.text = newsData.title
        articleContent.text = newsData.content
        articleDescription.text = newsData.description
        articleTime.text = newsData.publishedAt
        let author: String = newsData.author!
        
        if(author == "null"){
            articleSource.text = "By \(String(describing: newsData.source?.name))"
        }
        else{
            articleSource.text = "By \(author), \(newsData.source?.name ?? "")"
        }
    
        
        let imageLink =  URL(string: newsData.urlToImage ?? Config.IMAGE_PLACEHOLDER)
        do {
            if let imageUrlData = imageLink {
                let url_data = try Data(contentsOf: imageUrlData)
                articleImage.image = UIImage(data: url_data)
            }
            else{
                articleImage.image = #imageLiteral(resourceName: "ukrane")
            }
        }
        catch{
            print("Image Error", error)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func fullStoryTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SingleStory", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FullStoryVC") as! FullStoryVC
        newViewController.sourceUrl = newsData.url
        newViewController.modalPresentationStyle = .fullScreen
        present(newViewController, animated: true, completion: nil)
    }
}
