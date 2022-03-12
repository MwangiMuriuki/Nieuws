//
//  ViewController.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnGetStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnGetStarted.layer.cornerRadius = btnGetStarted.frame.height / 2
    }


    @IBAction func GetStartedClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
}

