//
//  ServiceCaller.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import Foundation
import Alamofire

class ServiceCaller{
    
    //MARK :- Properties
    var delegate: ServiceCallerDelegate?
    //MARK :- Methods
    
    func makeRequest(url : String, requestBody: [String : Any]?, method: HTTPMethod = .post, addHeaders : Bool = false, progresslabel: String = "", showProgress: Bool = true) {
        
        let headerValues : HTTPHeaders = HTTPHeaders()
        
        AF.request(url,
                   method: method,
                   parameters: requestBody,
                   headers: headerValues
        ).responseData { response in
           
            switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                    self.delegate?.successResponse(response: value)
                
                case .failure(let error):
                    print("Error: \(error)")
                    self.delegate?.errorResponse(error: error.localizedDescription)
            }
        }
    }
}

public protocol ServiceCallerDelegate{
    func successResponse(response: Data)
    func errorResponse(error: String)
}
