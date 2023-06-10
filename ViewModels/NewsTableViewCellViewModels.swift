//
//  NewsTableViewCellViewModel.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import Foundation

class NewsTableViewCellViewModel { /* 176 */
    let title: String /* 177 */
    let subtitle: String /* 178 */
    let imageURL: URL? /* 179 */
    var imageData: Data? = nil /* 180 */
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
    ) { /* 181 */
        self.title = title /* 182 */
        self.subtitle = subtitle /* 182 */
        self.imageURL = imageURL /* 182 */
    }
}
