//
//  ViewController.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-10.
//  Copyright © 2019 chovo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class CustomCollectionsViewController: UITableViewController {

    fileprivate let cellId = "customCollectionCell"
    fileprivate var customCollections : [CustomCollectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.1, green: 0.12, blue: 0.33, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white ]
    }
    
    fileprivate func setupTableView(){
        tableView.separatorStyle = .none
        tableView.register(CustomCollectionCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.9686, alpha: 1)
        loadCustomCollections()
    }

    
    fileprivate func loadCustomCollections(){
        ShopifyApiClient().fetchCustomCollections { (error, response) in
            if error{
                self.showAlert()
            } else {
                self.customCollections = response
                DispatchQueue.main.async{
                    self.tableView.separatorStyle = .singleLine
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func showAlert(){
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong loading the collections", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customCollections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCollectionCell
        let customCollectionModel = customCollections[indexPath.row]
        cell.updateWithDataModel(model: customCollectionModel)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToCollectionsDetailsViewController(customCollections[indexPath.row])
    }
    
    internal func navigateToCollectionsDetailsViewController(_ customCollection : CustomCollectionModel) {
        guard let navController = self.navigationController else {
            fatalError("CustomCollectionsViewController should always be embedded in a UINavigationController")
        }
        
        let collectionDetailsVC = CollectionDetailsViewController(customCollectionModel: customCollection)
        navController.pushViewController(collectionDetailsVC, animated: true)
    }

}

