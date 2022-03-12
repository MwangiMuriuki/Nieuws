//
//  NewsDataModelClass.swift
//  NewsApp
//
//  Created by Ernest Mwangi on 31/01/2022.
//

import Foundation

struct NewsDataModelClass : Codable{
    var status: String
    var totalResults: Int?
    var articles: [NewsData]?
    var code: String?
    var message: String?
}

struct NewsData : Codable{
    var source: NewsSource?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct NewsSource: Codable {
    var id: String?
    var name: String?
}
