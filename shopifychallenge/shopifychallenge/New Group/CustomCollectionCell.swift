//
//  CustomCollectionCell.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-11.
//  Copyright © 2019 chovo. All rights reserved.
//

import UIKit

class CustomCollectionCell: UITableViewCell {
    let titleLabel = UILabel()
    let collectionImageView = UIImageView()
    let descriptionLabel = UILabel()
    fileprivate let padding: CGFloat = 16
    fileprivate let imageHeight: CGFloat = 50
    fileprivate let imageRatio: CGFloat = 1
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(collectionImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        collectionImageView.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 1
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionLabel.textColor = .gray
        
        
        let imageViewConstraints = [collectionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                    collectionImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                                    collectionImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
                                    collectionImageView.heightAnchor.constraint(equalToConstant: imageHeight),
                                    collectionImageView.widthAnchor.constraint(equalToConstant: imageHeight * imageRatio)]
        
        let titleLabelConstraints = [titleLabel.topAnchor.constraint(equalTo: collectionImageView.topAnchor),
                                     titleLabel.leadingAnchor.constraint(equalTo: collectionImageView.trailingAnchor, constant: padding),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)]

        let descriptionLabelContstraints = [descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
                                            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -padding),
                                            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelContstraints)
    }
    
    internal func updateWithDataModel(model: CustomCollectionModel){
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        if let urlString = model.image {
            collectionImageView.af_setImage(withURL: URL(string: urlString)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
