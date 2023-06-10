//
//  PayWallHeaderView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class PayWallHeaderView: UIView { /* 596 */

    //Header Image
    private let headerImageView: UIImageView = { /* 596 */
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill")) /* 596 */
        imageView.frame = CGRect(x: 0, y: 0, width: 110, height: 110) /* 596 */
        imageView.tintColor = .white /* 596 */
        imageView.contentMode = .scaleAspectFit /* 596 */
        return imageView /* 159628 */
    }()
    
    override init(frame: CGRect) { /* 596 */
        super.init(frame: frame) /* 596 */
        clipsToBounds = true /* 596 */
        addSubview(headerImageView) /* 596 */
        backgroundColor = .systemPink /* 596 */
    }
    
    required init?(coder: NSCoder) { /* 596 */
        fatalError() /* 596 */
    }
    
    override func layoutSubviews() { /* 596 */
        super.layoutSubviews() /* 596 */
        headerImageView.frame = CGRect(x: (bounds.width - 110)/2, y: (bounds.height - 110)/2, width: 110, height: 110) /* 596 */
    }

}
