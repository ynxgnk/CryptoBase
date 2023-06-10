//
//  CryptoTableViewCellViewModel.swift
//  CryptoShield
//
//  Created by Nazar Kopeika on 04.06.2023.
//


import Foundation

class CryptoTableViewCellViewModel { /* 425 */
    let name: String /* 426 */
    let symbol: String /* 426 */
    let price: String /* 426 */
    let iconUrl: URL? /* 426 */
    var iconData: Data? /* 426 */
    
    init(
        name: String,
        symbol: String,
        price: String,
        iconUrl: URL?
    ) { /* 427 */
        self.name = name /* 428 */
        self.symbol = symbol /* 428  */
        self.price = price /* 428 */
        self.iconUrl = iconUrl /* 428 */
    }
}
