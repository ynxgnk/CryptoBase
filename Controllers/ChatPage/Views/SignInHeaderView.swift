//
//  SignInHeaderView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class SignInHeaderView: UIView {

    private let imageView: UIImageView = { /* 598 */
        let imageView = UIImageView(image: UIImage(named: "logo")) /* 598 */
        imageView.contentMode = .scaleAspectFit /* 598 */
        imageView.backgroundColor = .systemBackground /* 598 */
        return imageView /* 598 */
    }()
    
    private let label: UILabel = { /* 598 */
        let label = UILabel() /* 598 */
        label.textAlignment = .center /* 598 */
        label.numberOfLines = 0 /* 598 */
        label.font = .systemFont(ofSize: 20, weight: .medium) /* 598 */
        label.text = "Explore millions of articles!" /* 598 */
        return label /* 598 */
    }()
    
    override init(frame: CGRect) { /* 598 */
        super.init(frame: frame) /* 598 */
        clipsToBounds = true /* 598 */
        addSubview(label) /* 598 */
        addSubview(imageView) /* 598 */
    }
    
    required init?(coder: NSCoder) { /* 598 */
        fatalError() /* 598 */
    }
    
    override func layoutSubviews() { /* 598 */
        super.layoutSubviews() /* 598 */
        
        let size: CGFloat = width / 4 /* 598 */
        imageView.frame = CGRect(x: (width-size)/2, y: 10, width: size, height: size) /* 598 */
        label.frame = CGRect(x: 20, y: imageView.bottom+10, width: width-40, height: height-size-30) /* 598 */
    }

}
