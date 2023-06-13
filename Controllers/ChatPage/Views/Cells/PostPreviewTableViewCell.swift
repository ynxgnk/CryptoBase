//
//  PostPreviewTableViewCell.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class PostPreviewTableViewCellViewModel { /* 594 */
    let title: String /* 594 */
    let imageUrl: URL? /* 594 */
    var imageData: Data? /* 594 */
    let description: String /* 605 */
    let currentEmail: String /* 605 */
    
    init(title: String, imageUrl: URL?, description: String, currentEmail: String) { /* 594 */
        self.title = title /* 594 */
        self.imageUrl = imageUrl /* 594 */
        self.description = description /* 605 */
        self.currentEmail = currentEmail /* 605 */
    }
}

class PostPreviewTableViewCell: UITableViewCell {
    static let identifier = "PostPreviewTableViewCell" /* 594 */
    
    private let postImageView: UIImageView = { /* 594 */
        let imageView = UIImageView() /* 594 */
        imageView.layer.masksToBounds = true /* 594 */
        imageView.clipsToBounds = true /* 594 */
//        imageView.layer.cornerRadius = 8 /* 594 */
        imageView.contentMode = .scaleAspectFill /* 594 */
        return imageView /* 594 */
    }()
    
    private let postTitleLabel: UILabel = { /* 594 */
        let label = UILabel() /* 594 */
        label.numberOfLines = 0 /* 594 */
        label.font = .systemFont(ofSize: 20, weight: .medium) /* 594 */
        return label /* 594 */
    }()
    
    private let postDescriptionLabel: UILabel = { /* 605 */
        let label = UILabel() /* 605 */
        label.numberOfLines = 0 /* 605 */
        label.font = .systemFont(ofSize: 17, weight: .medium) /* 605 */
        return label /* 605 */
    }()
    
    public let nicknameLabel: UILabel = { /* 605 */
       let label = UILabel() /* 605 */
        label.numberOfLines = 1 /* 605 */
        label.font = .systemFont(ofSize: 15, weight: .semibold) /* 605 */
        return label /* 605 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 594 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 594 */
        contentView.clipsToBounds = true /* 594 */
        contentView.addSubview(postImageView) /* 594 */
        contentView.addSubview(postTitleLabel) /* 594 */
        contentView.addSubview(postDescriptionLabel) /* 605 */
        contentView.addSubview(nicknameLabel) /* 605 */
    }
    
    required init?(coder: NSCoder) { /* 594 */
        fatalError() /* 594 */
    }
    
    override func layoutSubviews() { /* 594 */
        super.layoutSubviews() /* 594 */
//        postImageView.backgroundColor = .blue
        postImageView.frame = CGRect(
            x: 10,
            y: 40,
            width: contentView.height-50,
            height: contentView.height-50
        ) /* 594 */
//        postTitleLabel.backgroundColor = .orange
        postTitleLabel.frame = CGRect(
            x: postImageView.right+10,
            y: 40,
            width: contentView.width-5-separatorInset.left-postImageView.width,
            height: 40
        ) /* 594 */
//        postDescriptionLabel.backgroundColor = .red
        postDescriptionLabel.frame = CGRect(
            x: postImageView.right + 10,
            y: postTitleLabel.bottom+5,
            width: contentView.width-5-separatorInset.left-postImageView.width,
            height: contentView.height-50-separatorInset.bottom-45
        ) /* 605 */
//        nicknameLabel.backgroundColor = .brown
        nicknameLabel.frame = CGRect(
            x: 10,
            y: 5,
            width: contentView.width-15,
            height: 30
        ) /* 605 */
    }
    
    override func prepareForReuse() { /* 594 */
        super.prepareForReuse() /* 594 */
        postTitleLabel.text = nil /* 594 */
        postImageView.image = nil /* 594 */
        postDescriptionLabel.text = nil /* 605 */
        nicknameLabel.text = nil /* 605 */
    }
    
    func configure(with viewModel: PostPreviewTableViewCellViewModel) { /* 594 */ /* 594 change String */
        postTitleLabel.text = viewModel.title /* 594 */
        postDescriptionLabel.text = viewModel.description /* 605 */ 
        nicknameLabel.text = viewModel.currentEmail /* 605 */
        
        if let data = viewModel.imageData { /* 594 */
            postImageView.image = UIImage(data: data) /* 594 */
        }
        else if let url = viewModel.imageUrl { /* 594 */
            //Fetch image & cache
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in /* 594 */
                guard let data = data else { /* 594 */
                    return /* 594 */
                }
                
                viewModel.imageData = data /* 594 */
                DispatchQueue.main.async { /* 594 */
                    self?.postImageView.image = UIImage(data: data) /* 594 */
                }
            }
            task.resume() /* 594 */
        }
    }

}
