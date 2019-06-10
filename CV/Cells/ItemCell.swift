//
//  ItemCell.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-09.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    static let cellId = "itemCell"
    
    var item: Item? {
        didSet {
            itemNameLabel.text = item?.itemName
            itemImage.image = item?.itemImage
        }
    }
    
    private let itemNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let itemImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemImage.addConstraintsWith(width: 30.0, height: 30.0)
        
        let stackView = UIStackView(arrangedSubviews: [itemImage,itemNameLabel])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        addSubview(stackView)
        
        stackView.bindFrameToSuperviewBounds(constant: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
