//
//  Alert.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import Foundation

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    private static func showCallAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default, handler: {(action: UIAlertAction) in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    
    static func showIncompleteFormAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Ugly Alert Code", message: "You should really refactor this")
    }
    
    static func showServerResponseErrorAlert(on vc: UIViewController , msg word : String) {
        showBasicAlert(on: vc, with: "Oops", message: word)
    }
    
    static func showInputAlert(on vc: UIViewController , msg word : String) {
        showBasicAlert(on: vc, with: "Input error", message: word)
    }

    static func showBasicAlert(on vc: UIViewController ,title t :String , msg word : String) {
        showBasicAlert(on: vc, with: t , message: word)
    }
    
    static func showInvalidEmailAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Invalid Email", message: "Please use a correct email")
    }
    
    static func showUnableToRetrieveDataAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Unable to Retrieve Data", message: "Network Error")
    }
    
    static func showCallLeadAlert(on vc: UIViewController, title t: String, msg word : String) {
        showCallAlert(on: vc, with: t, message:word)
    }
}
