//
//  ShopifyApi.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-12.
//  Copyright © 2019 chovo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import AlamofireObjectMapper


public final class ShopifyApiClient: NSObject {
    
    fileprivate final let CUSTOM_COLLECTIONS_API_URL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    fileprivate final let COLLECTS_API_URL = "https://shopicruit.myshopify.com/admin/collects.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    fileprivate final let PRODUCTS_API_URL = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    public func fetchCustomCollections(completion:@escaping (Bool, [CustomCollectionModel]) -> ()) {
        Alamofire.request(CUSTOM_COLLECTIONS_API_URL).responseArray(keyPath: "custom_collections") { (response: DataResponse<[CustomCollectionResponse]>) -> Void in
            if let responseArray  = response.result.value{
                completion(false, responseArray.map {CustomCollectionModel(customCollectionResponse: $0)} )
            }else{
                completion(true, [])
            }
        }
    }
    
    public func fetchProducts(_ collectionId: String, completion:@escaping (Bool, [ProductModel]) -> ()){
        Alamofire.request(COLLECTS_API_URL, method: .get, parameters: ["collection_id": collectionId]).responseArray(keyPath: "collects") { (response: DataResponse<[CollectResponse]>) -> Void in
            if let responseArray  = response.result.value{
                self.fetchProductsInCollection(productIds: responseArray, completion: { (error, response) in
                    if error {
                        completion(true, [])
                    }else{
                        completion(false, response)
                    }
                })
            }else{
                completion(true, [])
            }
        }
    }
    
    fileprivate func fetchProductsInCollection( productIds: [CollectResponse], completion:@escaping (Bool, [ProductModel]) -> ()){
        let params = ["ids": productIds.compactMap({$0.productId}).map {String($0)}.joined(separator: ",") ]
        Alamofire.request(PRODUCTS_API_URL, method: .get, parameters: params).responseArray(keyPath: "products") { (response: DataResponse<[ProductResponse]>) -> Void in
            if let responseArray  = response.result.value{
                completion(false, responseArray.map {ProductModel(productResponse: $0)} )
            }else{
                completion(true, [])
            }
        }
    }
}
