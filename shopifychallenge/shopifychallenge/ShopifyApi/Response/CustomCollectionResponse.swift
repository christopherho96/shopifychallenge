//
//  CustomCollectionsResponse.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-11.
//  Copyright © 2019 chovo. All rights reserved.
//

import ObjectMapper

class CustomCollectionResponse: Mappable {
    var id: Int?
    var title : String?
    var image : CustomCollectionImage?
    var description : String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        description <- map["body_html"]
    }
}

class CustomCollectionImage: Mappable {
    var url: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        url <- map["src"]
    }
}
