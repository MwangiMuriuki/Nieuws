//
//  Config.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import Foundation

class Config{
    
    static let BASE_URL: String = "https://newsapi.org/v2/"
    static let apKey: String = "8e46fc16a7744bb0a9937c53401cafed"
    
    static let TOP_HEADLINES: String = BASE_URL + "top-headlines"
    static let EVERYTHING_ENDPOINT: String = BASE_URL + "everything"
    static let SOURCES_ENDPOINT: String = TOP_HEADLINES + "/sources"
    
    static let IMAGE_PLACEHOLDER: String = "https://via.placeholder.com/600x400/cccccc/000000.png?text=Article+Image"
}
