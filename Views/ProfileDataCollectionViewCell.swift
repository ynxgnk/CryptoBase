//
//  ProfileTableViewCell.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import UIKit

class ProfileDataCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileDataCollectionViewCell" /* 591 */
    
    private let nameLabel: UILabel = { /* 565 */
        let label = UILabel() /* 566 */
        //        label.backgroundColor = .purple
        label.text = "Name" /* 567 */
        label.font = .systemFont(ofSize: 18, weight: .medium) /* 568 */
        label.numberOfLines = 1 /* 569 */
        return label /* 571 */
    }()
    
    private let emailLabel: UILabel = { /* 612 */
        let label = UILabel() /* 613 */
        //        label.backgroundColor = .purple
        label.text = "Email" /* 614 */
        label.font = .systemFont(ofSize: 18, weight: .medium) /* 615 */
        label.numberOfLines = 1 /* 616 */
        return label /* 617 */
    }()
    
    private let profileImage: UIImageView = { /* 592 */
        let imageView = UIImageView() /* 593 */
        imageView.contentMode = .scaleAspectFit /* 594 */
        //        imageView.backgroundColor = .systemIndigo
        imageView.layer.cornerRadius = 10 /* 595 */
        imageView.layer.borderWidth = 1 /* 596 */
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor /* 597 */
        imageView.image = UIImage(systemName: "person") /* 598 */
        return imageView /* 599 */
    }()
    
    private let isPremiumLabel: UILabel = { /* 600 */
        let label = UILabel() /* 600 */
        //        label.backgroundColor = .yellow
        label.numberOfLines = 1 /* 600 */
        label.font = .systemFont(ofSize: 15, weight: .regular) /* 600 */
        label.text = "Basic" /* 600 */
        return label /* 600 */
    }()
    
    private let isPremiumImage: UIImageView = { /* 601 */
        let imageView = UIImageView() /* 601 */
        //        imageView.backgroundColor = .systemMint
        imageView.image = UIImage(systemName: "car") /* 601 */
        imageView.layer.cornerRadius = 15 /* 601 */
        imageView.contentMode = .scaleAspectFit /* 601 */
        return imageView /* 601 */
    }()
    
    override init(frame: CGRect) { /* 602 */
        super.init(frame: frame) /* 602 */
        contentView.addSubview(nameLabel) /* 585 */
        contentView.addSubview(profileImage) /* 603 */
        contentView.addSubview(emailLabel) /* 603 */
        contentView.addSubview(isPremiumImage)  /* 603 */
        contentView.addSubview(isPremiumLabel) /* 603 */
    }
    
    required init?(coder: NSCoder) { /* 604 */
        fatalError() /* 604 */
    }
    
    override func layoutSubviews() { /* 606 */
        super.layoutSubviews()
        
        profileImage.frame = CGRect(x: 10, y: 50, width: 110, height: 110) /* 607 */
        profileImage.backgroundColor = .blue /* 608 */
        
        nameLabel.backgroundColor = .systemGreen /* 586 */
        nameLabel.frame = CGRect(x: 130, y: 50, width: 200, height: 30) /* 586 */
        
        emailLabel.backgroundColor = .blue /* 609 */
        emailLabel.frame = CGRect(x: 130, y: 90, width: 200, height: 30) /* 609 */
        
        isPremiumLabel.frame = CGRect(x: 130, y: 130, width: 70, height: 30) /* 610 */
        isPremiumLabel.backgroundColor = .systemBrown /* 610 */
        
        isPremiumImage.frame = CGRect(x: 200, y: 130, width: 30, height: 30) /* 611 */
        isPremiumImage.backgroundColor = .purple /* 611 */
        
    }
    
    
}
