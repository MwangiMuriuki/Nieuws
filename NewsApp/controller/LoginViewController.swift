//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var biometricButton: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bottomView.layer.cornerRadius = 30
    
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let context = LAContext()
          var error: NSError?

          if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
              let reason = "Identify yourself!"

              context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                  [weak self] success, authenticationError in

                  DispatchQueue.main.async {
                      if success {
                          
                          self!.gotoDashboard()
                          
//                          let ac = UIAlertController(title: "Authentication Successfull", message: "You have been verified successfully. Proceed.", preferredStyle: .alert)
//                          ac.addAction(UIAlertAction(title: "OK", style: .default))
//                          self!.present(ac, animated: true)
                        
                      } else {
                          let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                          ac.addAction(UIAlertAction(title: "OK", style: .default))
                          self!.present(ac, animated: true)
                      }
                  }
              }
          } else {
              let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
              ac.addAction(UIAlertAction(title: "OK", style: .default))
              self.present(ac, animated: true)
          }
    }
    

    
    // MARK: - Navigate to DashBoard
   func gotoDashboard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
    }


}
