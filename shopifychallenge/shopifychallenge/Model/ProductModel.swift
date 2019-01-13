//
//  ProductModel.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-12.
//  Copyright © 2019 chovo. All rights reserved.
//

import Foundation

public struct ProductModel{
    public let title: String?
    public let image: String?
    public let quanitity: Int?
    
    init(productResponse: ProductResponse) {
        title = productResponse.title
        image = productResponse.image?.url
        quanitity = productResponse.variants?.compactMap({$0.inventoryQuantity}).reduce(0, +)
    }
}

