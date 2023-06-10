//
//  PayWallDescriptionView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//

import UIKit

class PayWallDescriptionView: UIView {

    private let descriptorLabel: UILabel = { /* 597 */
        let label = UILabel() /* 597 */
        label.textAlignment = .center /* 597 */
        label.font = .systemFont(ofSize: 26, weight: .medium) /* 597 */
        label.numberOfLines = 0 /* 597 */
        label.text = "Join CryptoBase Premium to read unlimited articles and browse thousands of posts!" /* 597 */
        return label /* 597 */
    }()
    
    private let priceLabel: UILabel = { /* 597  */
        let label = UILabel() /* 597 */
        label.textAlignment = .center /* 597 */
        label.font = .systemFont(ofSize: 22, weight: .regular) /* 597 */
        label.numberOfLines = 1 /* 597 */
        label.text = "$4.99 / month" /* 597 */
        return label /* 597 */
    }()
    
    override init(frame: CGRect) { /* 597 */
        super.init(frame: frame) /* 597 */
        clipsToBounds = true /* 597 */
        addSubview(priceLabel) /* 597 */
        addSubview(descriptorLabel) /* 597 */
    }
    
    required init?(coder: NSCoder) { /* 597 */
        fatalError() /* 597 */
    }
    
    override func layoutSubviews() { /* 597 */
        super.layoutSubviews() /* 597 */
        descriptorLabel.frame = CGRect(x: 20, y: 0, width: width - 40, height: height / 2) /* 597 */
        priceLabel.frame = CGRect(x: 20, y: height / 2, width: width - 40, height: height / 2) /* 597 */
    }

}
