//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 26/02/2022.
//

import UIKit


class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        thumbNail.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func populateGeneralData(with model: NewsData){
        newsTitle.text = model.title
        newsDesc.text = model.description
        newsDate.text = model.publishedAt
        
        let imageLink =  URL(string: (model.urlToImage ?? Config.IMAGE_PLACEHOLDER))
        do {
            if let imageUrlData = imageLink {
                let url_data = try Data(contentsOf: imageUrlData)
                thumbNail.image = UIImage(data: url_data)
            
            }
            else{
                thumbNail.image = #imageLiteral(resourceName: "home_logo")
            }
        }
        catch{
            print("Image Error", error)
        }
        
        
    }
    
}
