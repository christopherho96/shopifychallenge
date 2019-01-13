//
//  TestCell.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-12.
//  Copyright © 2019 chovo. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let quantityLabel = UILabel()
    let separatorLine = UIView()
    fileprivate let padding: CGFloat = 16
    fileprivate let imageHeight: CGFloat = 50
    fileprivate let imageRatio: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        quantityLabel.numberOfLines = 1
        quantityLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        quantityLabel.textColor = .gray
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorLine.backgroundColor = UITableView().separatorColor
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(quantityLabel)
        addSubview(separatorLine)
        
        let imageViewConstraints = [imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                    imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                                    imageView.heightAnchor.constraint(equalToConstant: imageHeight),
                                    imageView.widthAnchor.constraint(equalToConstant: imageHeight * imageRatio)]
        
        let titleLabelConstraints = [titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
                                     titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)]
        
        let descriptionLabelContstraints = [quantityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                                            quantityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                            quantityLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)]
        
        let separatorLineConstraints = [separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
                                        separatorLine.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                                        separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        separatorLine.heightAnchor.constraint(equalToConstant: 0.5)]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelContstraints)
        NSLayoutConstraint.activate(separatorLineConstraints)
    }
    
    internal func updateWithDataModel(model: ProductModel){
        titleLabel.text = model.title
        if let quantity = model.quanitity {
            quantityLabel.text = "Quantity: " + String(quantity)
        }
        if let urlString = model.image {
            imageView.af_setImage(withURL: URL(string: urlString)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
