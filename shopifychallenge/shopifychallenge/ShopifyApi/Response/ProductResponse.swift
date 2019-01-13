//
//  ProductsResponse.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-12.
//  Copyright © 2019 chovo. All rights reserved.
//

import ObjectMapper

class ProductResponse: Mappable {
    var title: String?
    var variants: [Variant]?
    var image : ProductImage?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        variants <- map["variants"]
        image <- map["image"]
    }
}

class Variant: Mappable {
    var inventoryQuantity: Int?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        inventoryQuantity <- map["inventory_quantity"]
    }
}

class ProductImage: Mappable {
    var url: String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        url <- map["src"]
    }
}
