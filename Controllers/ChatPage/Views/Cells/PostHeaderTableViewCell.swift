//
//  PostHeaderTableViewCell.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class PostHeaderTableViewCellViewModel { /* 595 */
    let imageUrl: URL? /* 595 */
    var imageData: Data? /* 595 */
    
    init(imageUrl: URL?) { /* 595 */
        self.imageUrl = imageUrl /* 595 */
    }
}

class PostHeaderTableViewCell: UITableViewCell {
    static let identifier = "PostHeaderTableViewCell" /* 595 */
        
    private let postImageView: UIImageView = { /* 595 copy from PostPreviewTableViewCellViewModel and paste */
        let imageView = UIImageView() /* 595 */
        imageView.layer.masksToBounds = true /* 595 */
        imageView.clipsToBounds = true /* 595 */
        imageView.contentMode = .scaleAspectFill /* 595 */
        return imageView /* 595 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 595 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 595 */
        contentView.clipsToBounds = true /* 595 */
        contentView.addSubview(postImageView) /* 595 */
    }
    
    required init?(coder: NSCoder) { /* 595 */
        fatalError() /* 595 */
    }
    
    override func layoutSubviews() { /* 595 */
        super.layoutSubviews() /* 595 */
        postImageView.frame = contentView.bounds /* 595 */
    }
    
    override func prepareForReuse() { /* 595 */
        super.prepareForReuse() /* 595 */
        postImageView.image = nil /* 595 */
    }
    
    func configure(with viewModel: PostHeaderTableViewCellViewModel) { /* 595 */
        if let data = viewModel.imageData { /* 595 */
            postImageView.image = UIImage(data: data) /* 595 */
        }
        else if let url = viewModel.imageUrl { /* 595 */
            //Fetch image & cache
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in /* 595 */
                guard let data = data else { /* 595 */
                    return /* 595 */
                }
                
                viewModel.imageData = data /* 595 */
                DispatchQueue.main.async { /* 595 */
                    self?.postImageView.image = UIImage(data: data) /* 595 */
                }
            }
            task.resume() /* 595 */
        }
    }
}
