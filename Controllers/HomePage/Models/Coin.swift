//
//  Coin.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 06/12/22.
//

import Foundation
import SwiftUI /* 578 */
import Charts /* 578 */

// MARK: - using app.quicktype.io
// must conform to idenfiable protocol

struct sparklineIn7D : Codable{ /* 578 */
    let price : [Double] /* 578 */
}
struct Coin: Codable, Identifiable { /* 578 */
    let id, symbol, name: String /* 578 */
    let image: String /* 578 */
    let currentPrice: Double /* 578 */
    let marketCapRank : Int /* 578 */
    let marketCap, fullyDilutedValuation : Double? /* 578 */
    let totalVolume, high24H, low24H : Double? /* 578 */
    let priceChange24H, priceChangePercentage24H: Double /* 578 */
    let marketCapChange24H, marketCapChangePercentage24H: Double? /* 578 */
    let circulatingSupply, totalSupply, maxSupply, ath: Double? /* 578 */
    let athChangePercentage: Double? /* 578 */
    let athDate: String? /* 578 */
    let atl, atlChangePercentage: Double? /* 578 */
    let atlDate: String? /* 578 */
    let lastUpdated: String? /* 578 */
    let priceChangePercentage24HInCurrency: Double? /* 578 */
    let sparklineIn7D : sparklineIn7D? /* 578 */

    enum CodingKeys: String, CodingKey { /* 578 */
        case id, symbol, name, image /* 578 */
        case currentPrice = "current_price" /* 578 */
        case marketCap = "market_cap" /* 578 */
        case marketCapRank = "market_cap_rank" /* 578 */
        case fullyDilutedValuation = "fully_diluted_valuation" /* 578 */
        case totalVolume = "total_volume" /* 578 */
        case high24H = "high_24h" /* 578 */
        case low24H = "low_24h" /* 578 */
        case priceChange24H = "price_change_24h" /* 578 */
        case priceChangePercentage24H = "price_change_percentage_24h" /* 578 */
        case marketCapChange24H = "market_cap_change_24h" /* 578 */
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h" /* 578 */
        case circulatingSupply = "circulating_supply" /* 578 */
        case totalSupply = "total_supply" /* 578 */
        case maxSupply = "max_supply" /* 578 */
        case ath /* 578 */
        case athChangePercentage = "ath_change_percentage" /* 578 */
        case athDate = "ath_date" /* 578 */
        case atl /* 578 */
        case atlChangePercentage = "atl_change_percentage" /* 578 */
        case atlDate = "atl_date" /* 578 */
        case lastUpdated = "last_updated" /* 578 */
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency" /* 578 */
        case sparklineIn7D = "sparkline_in_7d" /* 578 */
    }
}
