//
//  HomeTableViewCell.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell" /* 361  */
    
    private let cryptoIcon: UIImageView = { /* 296 */
        let imageView = UIImageView() /* 297 */
        imageView.layer.cornerRadius = 6 /* 298 */
//        imageView.layer.masksToBounds = true /* 299 */
        imageView.clipsToBounds = true /* 300 */
//        imageView.backgroundColor = .red /* 301 */
        imageView.contentMode = .scaleAspectFill /* 302 */
//        imageView.image = UIImage(systemName: "person") /* 303 */
        return imageView /* 304 */
    }()
    
    private let cryptoTitleLabel: UILabel = { /* 333 */
       let label = UILabel() /* 334 */
//        label.text = "Title" /* 335 */
        label.font = .systemFont(ofSize: 20, weight: .semibold) /* 336 */
        label.textColor = .white /* 337 */
//        label.backgroundColor = .green
//        label.text?.uppercased() /* 338 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 339 */
//        label.textAlignment = .left /* 340 */
        label.numberOfLines = 1 /* 341 */
        return label /* 342 */
    }()
    
    private let cryptoSubtitleLabel: UILabel = { /* 344 */
       let label = UILabel() /* 345 */
//        label.text = "Subtitle" /* 347 */
        label.font = .systemFont(ofSize: 14, weight: .light) /* 348 */
        label.textColor = .white /* 349 */
//        label.backgroundColor = .brown
//        label.text?.uppercased() /* 350 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 351 */
//        label.textAlignment = .left /* 352 */
        label.numberOfLines = 1 /* 353 */
        return label /* 346 */
    }()
    
    private let cryptoPriceLabel: UILabel = { /* 362 */
       let label = UILabel() /* 363 */
//        label.text = "$27,775.20" /* 365 */
        label.font = .systemFont(ofSize: 20, weight: .semibold) /* 366 */
        label.textColor = .white /* 367 */
//        label.backgroundColor = .orange /* 368 */
        label.translatesAutoresizingMaskIntoConstraints = false /* 369 */
        label.numberOfLines = 1 /* 370 */
        return label /* 364 */
    }()
    
//    private let percentPriceLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 20, weight: .semibold)
//        label.textColor = .red
//        label.numberOfLines = 1
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 305 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 306 */
        contentView.addSubview(cryptoIcon) /* 312 */
        contentView.addSubview(cryptoTitleLabel) /* 343 */
        contentView.addSubview(cryptoSubtitleLabel) /* 360 */
        contentView.addSubview(cryptoPriceLabel) /* 371 */
//        contentView.addSubview(percentPriceLabel)
    }
    
    required init?(coder: NSCoder) { /* 306 */
        fatalError() /* 307 */
    }
    
    override func layoutSubviews() { /* 308 */
        super.layoutSubviews() /* 309 */
        self.layer.cornerRadius = 20 /* 376 */
        self.clipsToBounds = true /* 377 */
        
        addConstraints() /* 359 */
        cryptoIcon.frame = CGRect(x: 16, y: 16, width: 80, height: 80) /* 356 */
    }
    
    private func addConstraints() { /* 313 */
        // Thumbnail Image View constraints
        let margin: CGFloat = 16 /* 354 */
        NSLayoutConstraint.activate([ /* 355 */
            
            // Title Label constraints
            cryptoTitleLabel.leadingAnchor.constraint(equalTo: cryptoIcon.trailingAnchor, constant: margin), /* 357 */
            cryptoTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin), /* 357 */
            cryptoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin-40), /* 357 */
            
            // Subtitle Label constraints
            cryptoSubtitleLabel.leadingAnchor.constraint(equalTo: cryptoIcon.trailingAnchor, constant: margin), /* 358 */
            cryptoSubtitleLabel.topAnchor.constraint(equalTo: cryptoTitleLabel.bottomAnchor, constant: 8), /* 358 */
            cryptoSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin-40), /* 358 */
            cryptoSubtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -margin), /* 358 */
            
            //Price Label constraints
            cryptoPriceLabel.leadingAnchor.constraint(equalTo: cryptoIcon.trailingAnchor, constant: margin), /* 372 */
            cryptoPriceLabel.topAnchor.constraint(equalTo: cryptoSubtitleLabel.topAnchor, constant: margin+8), /* 372 */
            cryptoPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin-40), /* 372 */
            
//            percentPriceLabel.leadingAnchor.constraint(equalTo: cryptoIcon.trailingAnchor, constant: margin), /* 372 */
//            percentPriceLabel.topAnchor.constraint(equalTo: cryptoSubtitleLabel.topAnchor, constant: margin), /* 372 */
//            percentPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin-40), /* 372 */
            
                                    ])
    }
            
            override func prepareForReuse() { /* 310 */
                super.prepareForReuse() /* 311 */
                cryptoIcon.image = nil /* 373 */
                cryptoPriceLabel.text = nil /* 374 */
                cryptoTitleLabel.text = nil /* 374 */
                cryptoSubtitleLabel.text = nil /* 374 */
//                percentPriceLabel.text = nil /* 374 */
            }
            
            public func cryptoConfigure(with viewModel: CryptoTableViewCellViewModel) { /* 429 */
                cryptoTitleLabel.text = viewModel.name /* 430 */
                cryptoPriceLabel.text = viewModel.price /* 431 */
                cryptoSubtitleLabel.text = viewModel.symbol /* 432 */

                if let data = viewModel.iconData { /* 433 */
                    cryptoIcon.image = UIImage(data: data) /* 434 */
                }
                
                else if let url = viewModel.iconUrl { /* 435 */
                    let task = URLSession.shared.dataTask(with: url) { [weak self] data , _, error in /* 436 */
                        if let data = data { /* 437 */
                            viewModel.iconData = data /* 438 */
                            DispatchQueue.main.async { /* 439 */
                                self?.cryptoIcon.image = UIImage(data: data) /* 440 */
                            }
                        }
                    }

                    task.resume() /* 441 */
                }
            }
        }
