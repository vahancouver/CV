//
//  ExperienceCell.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-09.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell {
    
    static let cellId = "experienceCell"
    
    var experience: CV.Experience? {
        didSet {
            companyNameLabel.text = experience?.companyName
            roleLabel.text = experience?.role
            fromToLabel.text = "\(experience?.from ?? "") - \(experience?.to ?? "present")"
            descriptionLabel.text = experience?.description
            
            downloadCompanyLogo(urlAddress: experience?.companyLogoUrlAddress)
        }
    }
    
    private func downloadCompanyLogo(urlAddress: String?) {
        ImageService.downloadImage(with: urlAddress) { (image, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.companyLogoImage.image = UIImage(named: "placeholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.companyLogoImage.image = image
            }
        }
    }
    
    private let companyNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let roleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let fromToLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let companyLogoImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let companyStackView = UIStackView(arrangedSubviews: [companyLogoImage, companyNameLabel])
        companyStackView.translatesAutoresizingMaskIntoConstraints = false
        companyStackView.distribution = .fillProportionally
        companyStackView.alignment = .center
        companyStackView.axis = .horizontal
        companyStackView.spacing = 10
        
        companyLogoImage.addConstraintsWith(width: 30.0, height: 30.0)
        
        let roleStackView = UIStackView(arrangedSubviews: [roleLabel, fromToLabel])
        roleStackView.translatesAutoresizingMaskIntoConstraints = false
        roleStackView.distribution = .fill
        roleStackView.alignment = .center
        roleStackView.axis = .horizontal
        roleStackView.spacing = 10
        
        
        let stackView = UIStackView(arrangedSubviews: [companyStackView, roleStackView, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        addSubview(stackView)
        stackView.bindFrameToSuperviewBounds(constant: 10)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
