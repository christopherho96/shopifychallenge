//
//  CustomCollectionModel.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-12.
//  Copyright © 2019 chovo. All rights reserved.
//

import Foundation

public struct CustomCollectionModel{
    public let id: Int?
    public let title: String?
    public let image: String?
    public let description: String?
    
    init(customCollectionResponse: CustomCollectionResponse) {
        id = customCollectionResponse.id
        title = customCollectionResponse.title
        image = customCollectionResponse.image?.url
        description = customCollectionResponse.description
    }
}
