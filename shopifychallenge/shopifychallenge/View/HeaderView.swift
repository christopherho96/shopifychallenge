//
//  HeaderView.swift
//  shopifychallenge
//
//  Created by Christopher Ho on 2019-01-10.
//  Copyright © 2019 chovo. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    let imageView = UIImageView()
    let descriptionTextView = UITextView()
    
    override init(frame: CGRect){
        super.init(frame: frame)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionTextView.textColor = .white
        descriptionTextView.backgroundColor = UIColor.init(red: 0.23, green: 0.25, blue: 0.41, alpha: 1)
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16)
        descriptionTextView.showTextDropShadow()
        
        addSubview(imageView)
        addSubview(descriptionTextView)
        
        let imageViewConstraints = [imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                    imageView.topAnchor.constraint(equalTo: topAnchor),
                                    imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                    imageView.heightAnchor.constraint(equalToConstant: 200)]
        
        let descriptionLabelContstraints = [descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                                            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelContstraints)
    }
    
    internal func updateImage(model: CustomCollectionModel){
        if let urlString = model.image {
            imageView.af_setImage(withURL: URL(string: urlString)!)
        }
        descriptionTextView.text = model.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextView {
    func showTextDropShadow() {
        self.clipsToBounds = false
        self.layer.shadowOpacity=0.4
        self.layer.shadowOffset = CGSize(width: self.frame.width, height: 2)
    }
}
