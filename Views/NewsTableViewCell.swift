//
//  NewsTableViewCell.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell" /* 32 */
    
    private let subtitleLabel: UILabel = { /* 183 */
        let label = UILabel() /* 184 */
        label.numberOfLines = 0 /* 185 */
        label.font = .systemFont(ofSize: 17, weight: .light) /* 186 */
        return label /* 187 */
    }()
    
    private let newsImageView: UIImageView = { /* 40 */
        let imageView = UIImageView() /* 41 */
        imageView.layer.cornerRadius = 6 /* 188 */
        imageView.layer.masksToBounds = true /* 189 */
        imageView.clipsToBounds = true /* 190 */
        imageView.backgroundColor = .secondarySystemBackground /* 191 */
        imageView.contentMode = .scaleToFill /* 192 */
//        imageView.image = UIImage(systemName: "person") /* 44 */
        return imageView /* 43 */
    }()
    
    private let newsTitleLabel: UILabel = { /* 53 */
        let text = UILabel() /* 54 */
        text.numberOfLines = 0 /* 137 */
//        text.text = "HHhHHHHHHHH HHhHHHHHHH"
        text.font = .systemFont(ofSize: 22, weight: .semibold) /* 138 */
        return text /* 58 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 33 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 34 */
//        contentView.backgroundColor = .systemPink /* 35 */
        contentView.addSubview(newsImageView) /* 47 */
        contentView.addSubview(newsTitleLabel) /* 67 */
        contentView.addSubview(subtitleLabel) /* 193 */
    }
    
    override func prepareForReuse() { /* 197 */
        super.prepareForReuse() /* 198 */
        newsTitleLabel.text = nil /* 199 */
        subtitleLabel.text = nil /* 199 */
        newsImageView.image = nil /* 199 */
    }
    
    required init?(coder: NSCoder) { /* 36 */
        fatalError() /* 37 */
    }
    
    override func layoutSubviews() { /* 38 */
        super.layoutSubviews() /* 39 */
        NewsConstraints() /* 196 */
    }
    
    private func NewsConstraints() { /* 195 */
        newsImageView.frame = CGRect(
            x: contentView.frame.size.width-150,
            y: 5,
            width: 160,
            height: contentView.frame.size.height-10
        ) /* 48 */
//        newsImageView.backgroundColor = .yellow /* 42 */
        newsTitleLabel.frame = CGRect(
            x: 10,
            y: 5,
            width: contentView.frame.size.width-170,
            height: 70
        ) /* 45 */
//        newsTitleLabel.backgroundColor = .green /* 46 */
        subtitleLabel.frame = CGRect(
            x: 10,
            y: 70,
            width: contentView.frame.size.width-170,
            height: contentView.frame.size.height/2
        ) /* 194 */
//        subtitleLabel.backgroundColor = .red
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) { /* 200 */
        newsTitleLabel.text = viewModel.title /* 201 */
        subtitleLabel.text = viewModel.subtitle /* 202 */
        
        //Image
        if let data = viewModel.imageData { /* 203 */
            newsImageView.image = UIImage(data: data) /* 204 */
        }
        else if let url = viewModel.imageURL { /* 205 */
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data , _, error in /* 206 */
                guard let data = data, error == nil else { /* 207 */
                    return /* 208 */
                }
                
                viewModel.imageData = data /* 209 */
                DispatchQueue.main.async { /* 210 */
                    self?.newsImageView.image = UIImage(data: data) /* 211 */
                }
            }.resume() /* 212 */
        }
    }
}
