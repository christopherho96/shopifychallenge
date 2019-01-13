//
//  CollectsResponse.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-12.
//  Copyright © 2019 chovo. All rights reserved.
//

import ObjectMapper

class CollectResponse: Mappable {
    var productId: Int?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        productId <- map["product_id"]
    }
}
