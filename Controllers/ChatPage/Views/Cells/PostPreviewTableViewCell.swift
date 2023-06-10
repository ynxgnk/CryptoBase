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
    
    init(title: String, imageUrl: URL?) { /* 594 */
        self.title = title /* 594 */
        self.imageUrl = imageUrl /* 594 */
    }
}

class PostPreviewTableViewCell: UITableViewCell {
    static let identifier = "PostPreviewTableViewCell" /* 594 */
    
    private let postImageView: UIImageView = { /* 594 */
        let imageView = UIImageView() /* 594 */
        imageView.layer.masksToBounds = true /* 594 */
        imageView.clipsToBounds = true /* 594 */
        imageView.layer.cornerRadius = 8 /* 594 */
        imageView.contentMode = .scaleAspectFill /* 594 */
        return imageView /* 594 */
    }()
    
    private let postTitleLabel: UILabel = { /* 594 */
        let label = UILabel() /* 594 */
        label.numberOfLines = 0 /* 594 */
        label.font = .systemFont(ofSize: 20, weight: .medium) /* 594 */
        return label /* 594 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 594 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 594 */
        contentView.clipsToBounds = true /* 594 */
        contentView.addSubview(postImageView) /* 594 */
        contentView.addSubview(postTitleLabel) /* 594 */
    }
    
    required init?(coder: NSCoder) { /* 594 */
        fatalError() /* 594 */
    }
    
    override func layoutSubviews() { /* 594 */
        super.layoutSubviews() /* 594 */
        postImageView.frame = CGRect(
            x: separatorInset.left,
            y: 5,
            width: contentView.height-10,
            height: contentView.height-10
        ) /* 594 */
        postTitleLabel.frame = CGRect(
            x: postImageView.right+5,
            y: 5,
            width: contentView.width-5-separatorInset.left-postImageView.width,
            height: contentView.height-10
        ) /* 594 */
    }
    
    override func prepareForReuse() { /* 594 */
        super.prepareForReuse() /* 594 */
        postTitleLabel.text = nil /* 594 */
        postImageView.image = nil /* 594 */
    }
    
    func configure(with viewModel: PostPreviewTableViewCellViewModel) { /* 594 */ /* 594 change String */
        postTitleLabel.text = viewModel.title /* 594 */
        
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
