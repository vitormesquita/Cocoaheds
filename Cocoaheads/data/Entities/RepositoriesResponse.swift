//
//  RepositoriesResponse.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 13/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import ObjectMapper

class RepositoriesResponse: Mappable {
    
    var totalCount: Int?
    var repositories: [Repository]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        totalCount <- map["total_count"]
        repositories <- map["items"]
    }
}
