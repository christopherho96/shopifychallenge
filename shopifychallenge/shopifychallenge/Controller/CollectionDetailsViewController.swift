//
//  CustomCollectionViewController.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-10.
//  Copyright © 2019 chovo. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class CollectionDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var customCollectionModel : CustomCollectionModel
    fileprivate let cellId = "productCell"
    fileprivate let headerId = "headerCell"
    fileprivate var products : [ProductModel] = []
    fileprivate let padding: CGFloat = 16
    fileprivate let imageHeight: CGFloat = 50
    fileprivate let imageRatio: CGFloat = 1

    internal init(customCollectionModel: CustomCollectionModel) {
        self.customCollectionModel = customCollectionModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionViewLayout()
        setupCollectionView()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = customCollectionModel.title
    }
    
    fileprivate func setupCollectionViewLayout(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.9686, alpha: 1)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        loadProducts()
    }
    
    fileprivate func loadProducts(){
        ShopifyApiClient().fetchProducts(String(customCollectionModel.id!)) { (error, response) in
            if error {
                self.showAlert()
            } else {
                DispatchQueue.main.async{
                    self.products = response
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func showAlert(){
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong loading the products", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        header.updateImage(model: customCollectionModel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if customCollectionModel.description != "" {
            let estimatedDescriptionFrame = NSString(string: customCollectionModel.description!).boundingRect(with: CGSize(width: self.view.frame.width - 32, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .light)], context: nil)
            return CGSize(width: view.frame.width , height: estimatedDescriptionFrame.height + 216)
        }
        return CGSize(width: view.frame.width , height: 200)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.updateWithDataModel(model: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: imageHeight + padding * 2 )
    }
}
