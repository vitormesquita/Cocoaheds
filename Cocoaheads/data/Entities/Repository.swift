//
//  Repository.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 13/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import ObjectMapper

class Repository: Mappable {
    
    var id: Int?
    var name: String?
    var htmlURLString: String?
    var description: String?
    var starsCount: Int?
    var language: String?
    var forksCount: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        htmlURLString <- map["html_url"]
        description <- map["description"]
        starsCount <- map["stargazers_count"]
        language <- map["language"]
        forksCount <- map["forks_count"]
    }
}
