//
//  Titles.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import Foundation

struct NewsTitlesModel: Codable { /* 162 */
    let source: Source /* 163 */
    let title: String /* 163 */
    let description: String? /* 163 */
    let url: String? /* 163 */
    let urlToImage: String? /* 163 */
    let publishedAt: String /* 163 */
}

struct Source: Codable { /* 164 */
    let name: String /* 165 */
}
