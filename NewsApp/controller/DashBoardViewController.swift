//
//  DashBoardViewController.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import UIKit
import Alamofire
import LGButton

class DashBoardViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var segmentCtrl: CustomSegmentedControl = {
        let v = CustomSegmentedControl()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.commaSeperatedButtonTitles = "General, Business, Technology, Sports"
        return v
    }()
    
    lazy var bottomView: UIView = {
        let ui = UIView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.backgroundColor = Colors.mainBGColor
        return ui
    }()
    
    var generalNewsVC: GeneralNewsVC!
    var businessNewsVC: BusinessNewsVC!
    var techNewsVC: TechnologyNewsVC!
    var sportsNewsVC: SportsNewsVC!
    
    @IBOutlet weak var countryDropDown: LGButton!
    @IBOutlet weak var flagIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        addSubViews()
        setConstraints()
        addChildVC()
        segmentCtrl.addTarget(self, action: #selector(handleSegmentControlChanged(sender:)), for: .valueChanged)
    }
    
    func initViews(){
        flagIcon.layer.cornerRadius = flagIcon.frame.height / 2
        
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
    
    func addSubViews(){
        contentView.addSubview(segmentCtrl)
        contentView.addSubview(bottomView)
        
    }
    
    func setConstraints(){
        segmentCtrl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        segmentCtrl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        segmentCtrl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        segmentCtrl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: segmentCtrl.bottomAnchor, constant: 10).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func addChildVC(){
        let storyboard = UIStoryboard(name: Constants.CATEGORIES, bundle: nil)
        generalNewsVC = storyboard.instantiateViewController(withIdentifier: String.init(describing: GeneralNewsVC.self)) as? GeneralNewsVC
        businessNewsVC = storyboard.instantiateViewController(withIdentifier: String.init(describing: BusinessNewsVC.self)) as? BusinessNewsVC
        techNewsVC = storyboard.instantiateViewController(withIdentifier: String.init(describing: TechnologyNewsVC.self)) as? TechnologyNewsVC
        sportsNewsVC = storyboard.instantiateViewController(withIdentifier: String.init(describing: SportsNewsVC.self)) as? SportsNewsVC
        
        addChild(generalNewsVC)
        addChild(businessNewsVC)
        addChild(techNewsVC)
        addChild(sportsNewsVC)
        
        bottomView.addSubview(generalNewsVC.view)
        bottomView.addSubview(businessNewsVC.view)
        bottomView.addSubview(techNewsVC.view)
        bottomView.addSubview(sportsNewsVC.view)
        
        generalNewsVC.didMove(toParent: self)
        businessNewsVC.didMove(toParent: self)
        techNewsVC.didMove(toParent: self)
        sportsNewsVC.didMove(toParent: self)
        
        generalNewsVC.view.frame = bottomView.frame
        businessNewsVC.view.frame = bottomView.frame
        techNewsVC.view.frame = bottomView.frame
        sportsNewsVC.view.frame = bottomView.frame
        
        businessNewsVC.view.isHidden = true
        techNewsVC.view.isHidden = true
        sportsNewsVC.view.isHidden = true
    }
    
    @objc func handleSegmentControlChanged(sender: CustomSegmentedControl) {
        print("handleSegmentControlChanged \(sender.selectedSegmentIndex)")
        switch sender.selectedSegmentIndex  {
            
        case 0:
            // show General vc
            generalNewsVC.view.isHidden = false
            generalNewsVC.fetchTopHeadlines()
            businessNewsVC.view.isHidden = true
            techNewsVC.view.isHidden = true
            sportsNewsVC.view.isHidden = true
            break
        case 1:
            // show business vc
            generalNewsVC.view.isHidden = true
            businessNewsVC.view.isHidden = false
            //businessNewsVC.fetchNews()
            techNewsVC.view.isHidden = true
            sportsNewsVC.view.isHidden = true
            break
        case 2:
            // show tech vc
            generalNewsVC.view.isHidden = true
            businessNewsVC.view.isHidden = true
            techNewsVC.view.isHidden = false
            //techNewsVC.fetchNews()
            sportsNewsVC.view.isHidden = true
            break
        case 3:
            // show sports vc
            generalNewsVC.view.isHidden = true
            businessNewsVC.view.isHidden = true
            techNewsVC.view.isHidden = true
            sportsNewsVC.view.isHidden = false
            //sportsNewsVC.fetchNews()
            break
        default:
            generalNewsVC.view.isHidden = false
            generalNewsVC.fetchTopHeadlines()
            businessNewsVC.view.isHidden = true
            techNewsVC.view.isHidden = true
            sportsNewsVC.view.isHidden = true
            break
        }
    }
    
}

