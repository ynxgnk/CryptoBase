//
//  Icons.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//

import Foundation

struct Crypto: Codable { /* 390 */
    let asset_id: String /* 391 */
    let name: String? /* 391 */
    let price_usd: Float? /* 391 */
    let id_icon: String? /* 391 */
}

struct Icon: Codable { /* 392 */
    let asset_id: String /* 393 */
    let url: String /* 393 */
}
