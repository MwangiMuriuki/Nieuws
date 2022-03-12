//
//  BusinessNewsVC.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 26/02/2022.
//

import UIKit

class BusinessNewsVC: UIViewController {

    var activityIndicator = UIActivityIndicatorView(style: .large)
    let service = ServiceCaller()
    var serverurl: String = ""
    var authorization: String = ""
    var country: String = "us"
    var category: String = "business"
    var newsArtices = [NewsData]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        service.delegate = self
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchTopHeadlines()
    }
    
    func initViews(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7041453178)
        activityIndicator.color = .white
        activityIndicator.layer.cornerRadius = 10
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - Fetch Top Headlines
    func fetchTopHeadlines(){
        activityIndicator.startAnimating()
        serverurl = Config.TOP_HEADLINES
        authorization = Config.apKey
        
        let reqBody = ["apiKey" : authorization,
                       "country": country,
                       "category": category]
        
        service.makeRequest(url: serverurl, requestBody: reqBody, method: .get)
        
    }
}

extension BusinessNewsVC: ServiceCallerDelegate{
    func successResponse(response: Data) {
        do {
            let myResp = try JSONDecoder().decode(NewsDataModelClass.self, from: response)
            print("Response: \(myResp)")
            
            newsArtices = myResp.articles!
            
            let articleNumber = myResp.articles?.count
            print(articleNumber as Any)
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
            
        }  catch let DecodingError.dataCorrupted(context) {
            activityIndicator.stopAnimating()
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            activityIndicator.stopAnimating()
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            activityIndicator.stopAnimating()
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            activityIndicator.stopAnimating()
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            activityIndicator.stopAnimating()
            print("error: ", error)
        }
    }
    
    func errorResponse(error: String) {
        print("Failed")
        activityIndicator.stopAnimating()
        print("Error \(error)")
        Alert.showBasicAlert(on: self, title: "Server error", msg: error.description)
    }
}

extension BusinessNewsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArtices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        cell.populateGeneralData(with: newsArtices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = newsArtices[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "SingleStory", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleStoryVC") as! SingleStoryVC
        newViewController.newsData = data
        newViewController.modalPresentationStyle = .fullScreen
        present(newViewController, animated: true, completion: nil)
    }
    
}
