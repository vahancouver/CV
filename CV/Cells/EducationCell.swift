//
//  EducationCell.swift
//  CV
//
//  Created by Vahan Harutyunyan on 2019-06-09.
//  Copyright © 2019 Vahan Harutyunyan. All rights reserved.
//

import UIKit

class EducationCell: UITableViewCell {
    
    static let cellId = "educationCell"
    
    var education: CV.Education? {
        didSet {
            universityNameLabel.text = education?.universityName
            degreeLabel.text = education?.degree
            fromToLabel.text = "\(education?.from ?? "") - \(education?.to ?? "present")"
            downloadUniversityLogo(urlAddress: education?.universityLogoUrlAddress)
        }
    }
    
    private func downloadUniversityLogo(urlAddress: String?) {
        DispatchQueue.global(qos: .background).async {
            guard let urlAddress = urlAddress,
                let url = URL(string: urlAddress),
                let data = try? Data(contentsOf: url),
                let image: UIImage = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.universityLogoImage.image = UIImage(named: "placeholder")
                    }
                    return
            }
            DispatchQueue.main.async {
                self.universityLogoImage.image = image
            }
        }
    }
    
    private let universityNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let degreeLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let fromToLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
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
    
    private let universityLogoImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "placeholder"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let universityStackView = UIStackView(arrangedSubviews: [universityLogoImage, universityNameLabel])
        universityStackView.translatesAutoresizingMaskIntoConstraints = false
        universityStackView.distribution = .fillProportionally
        universityStackView.alignment = .center
        universityStackView.axis = .horizontal
        universityStackView.spacing = 10
        
        universityLogoImage.addConstraintsWith(width: 30.0, height: 30.0)
        
        let degreeStackView = UIStackView(arrangedSubviews: [degreeLabel, fromToLabel])
        degreeStackView.translatesAutoresizingMaskIntoConstraints = false
        degreeStackView.distribution = .fillProportionally
        degreeStackView.alignment = .center
        degreeStackView.axis = .horizontal
        degreeStackView.spacing = 10
        
        
        let stackView = UIStackView(arrangedSubviews: [universityStackView, degreeStackView])
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
