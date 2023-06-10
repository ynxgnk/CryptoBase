//
//  APIResponse.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import Foundation

struct NewsAPIResponse: Codable { /* 166 */
    let articles: [NewsTitlesModel] /* 167 */
}

struct CryptoAPIResponse: Codable { /* 520 */
    let icons: [Crypto] /* 521 */
}
