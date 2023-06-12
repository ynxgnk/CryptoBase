//
//  ProfileTableViewCell.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

/*

import UIKit

class ProfileDataCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileDataCollectionViewCell" /*  */
    
    private let nameLabel: UILabel = { /*  */
        let label = UILabel() /*  */
        //        label.backgroundColor = .purple
        label.text = "Name" /*  */
        label.font = .systemFont(ofSize: 18, weight: .medium) /*  */
        label.numberOfLines = 1 /*  */
        return label /*  */
    }()
    
    private let emailLabel: UILabel = { /*  */
        let label = UILabel() /*  */
        //        label.backgroundColor = .purple
        label.text = "Email" /*  */
        label.font = .systemFont(ofSize: 18, weight: .medium) /*  */
        label.numberOfLines = 1 /*  */
        return label /*  */
    }()
    
    private let profileImage: UIImageView = { /*  */
        let imageView = UIImageView() /*  */
        imageView.contentMode = .scaleAspectFit /*  */
        //        imageView.backgroundColor = .systemIndigo
        imageView.layer.cornerRadius = 10 /*  */
        imageView.layer.borderWidth = 1 /*  */
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor /*  */
        imageView.image = UIImage(systemName: "person") /*  */
        return imageView /*  */
    }()
    
    private let isPremiumLabel: UILabel = { /*  */
        let label = UILabel() /*  */
        //        label.backgroundColor = .yellow
        label.numberOfLines = 1 /*  */
        label.font = .systemFont(ofSize: 15, weight: .regular) /*  */
        label.text = "Basic" /*  */
        return label /*  */
    }()
    
    private let isPremiumImage: UIImageView = { /*  */
        let imageView = UIImageView() /*  */
        //        imageView.backgroundColor = .systemMint
        imageView.image = UIImage(systemName: "car") /*  */
        imageView.layer.cornerRadius = 15 /*  */
        imageView.contentMode = .scaleAspectFit /*  */
        return imageView /*  */
    }()
    
    override init(frame: CGRect) { /*  */
        super.init(frame: frame) /*  */
        contentView.addSubview(nameLabel) /*  */
        contentView.addSubview(profileImage) /*  */
        contentView.addSubview(emailLabel) /*  */
        contentView.addSubview(isPremiumImage)  /*  */
        contentView.addSubview(isPremiumLabel) /*  */
    }
    
    required init?(coder: NSCoder) { /*  */
        fatalError() /*  */
    }
    
    override func layoutSubviews() { /*  */
        super.layoutSubviews()
        
        profileImage.frame = CGRect(x: 10, y: 50, width: 110, height: 110) /*  */
        profileImage.backgroundColor = .blue /*  */
        
        nameLabel.backgroundColor = .systemGreen /*  */
        nameLabel.frame = CGRect(x: 130, y: 50, width: 200, height: 30) /*  */
        
        emailLabel.backgroundColor = .blue /*  */
        emailLabel.frame = CGRect(x: 130, y: 90, width: 200, height: 30) /*  */
        
        isPremiumLabel.frame = CGRect(x: 130, y: 130, width: 70, height: 30) /*  */
        isPremiumLabel.backgroundColor = .systemBrown /*  */
        
        isPremiumImage.frame = CGRect(x: 200, y: 130, width: 30, height: 30) /*  */
        isPremiumImage.backgroundColor = .purple /*  */
        
    }
    
    
}
*/
