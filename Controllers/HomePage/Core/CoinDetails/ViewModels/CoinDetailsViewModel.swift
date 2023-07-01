//
//  CoinDetailsViewModel.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 13/12/22.
//

import Foundation
import SwiftUI

class CoinDetailsViewModel{ /* 570 */
    
    private let coin : Coin /* 570 */
    
    // chart config
    var charData = [ChartData]() /* 570 */
    var startDate = Date() /* 570 */
    var endDate = Date() /* 570 */
    var minPrice = 0.0 /* 570 */
    var maxPrice = 0.0 /* 570 */
    var xAxisValues = [Date]() /* 570 */
    var yAxisValues = [Double]() /* 570 */
    
    var coinName : String{ /* 570 */
        return coin.name /* 570 */
    }
    var chartLineColor : Color{ /* 570 */
        let priceDelta = (coin.sparklineIn7D?.price.last ?? 0) - (coin.sparklineIn7D?.price.first ?? 0) /* 570 */
        return (priceDelta > 0) ? .green : .pink /* 570 */
    }
    
    var overviewSectionModel : CoinDetailsSectionModel{ /* 570 */
        // price stats
        let price = coin.currentPrice.toCurrency() /* 570 */
        let pricePercentageChange = coin.priceChangePercentage24H /* 570 */
        let priceStats = StatiscticModel(title: "CurrentPrice", value: price, percentageChange: pricePercentageChange) /* 570 */
        
        // market stats
        var mc : String = "" /* 570 */
        if let marketCap = coin.marketCap { /* 570 */
            mc = marketCap.formattedWithAbbreviations() /* 570 */
                    }
        let marketCapPercentageChange = coin.marketCapChangePercentage24H /* 570 */
        print("Debug: " + mc + " marketCap") /* 570 */
        let marketCapStat = StatiscticModel(title: "Market Cap", value: mc, percentageChange: marketCapPercentageChange) /* 570 */

        // rank stats
        let rank = coin.marketCapRank /* 570 */
        let rankStat = StatiscticModel(title: "Rank", value: "\(rank)", percentageChange: nil) /* 570 */
        
        // volume stats
        let volume = coin.totalVolume ?? 0 /* 570 */
        let volumeStat = StatiscticModel(title: "Volume", value: volume.formattedWithAbbreviations(), percentageChange: nil) /* 570 */
        
        return CoinDetailsSectionModel(title: "Overview", stats: [priceStats, marketCapStat, rankStat, volumeStat]) /* 570 */
    }
    
    var additionalDetailsSectionModel : CoinDetailsSectionModel{ /* 570 */
        // 24H high
        let high = coin.high24H?.toCurrency() ?? "n/a" /* 570 */
        let highStat = StatiscticModel(title: "24H High", value: high, percentageChange: nil) /* 570 */
        
        // 24H low
        let low = coin.low24H?.toCurrency() ?? "n/a" /* 570 */
        let lowStat = StatiscticModel(title: "low", value: low, percentageChange: nil) /* 570 */
        
        // 24H price change
        let priceChange24H = coin.priceChange24H.toCurrency() /* 570 */
        let percentageChange24H = coin.priceChangePercentage24H /* 570 */
        let priceChangeStat = StatiscticModel(title: "24H priceChange", value: priceChange24H, percentageChange: percentageChange24H) /* 570 */
        
        // 24H market cap change
        let marketCapChange = coin.marketCapChange24H ?? 0 /* 570 */
        let marketCapChangePercentage = coin.marketCapChangePercentage24H /* 570 */
        let marketStat = StatiscticModel(title: "24H Market CapChange", value: "$\(marketCapChange.formattedWithAbbreviations())", percentageChange: marketCapChangePercentage) /* 570 */
        
        return CoinDetailsSectionModel(title: "Additional details", stats: [highStat, lowStat, priceChangeStat, marketStat]) /* 570 */
    }
    
    init(coin: Coin) { /* 570 */
        self.coin = coin /* 570 */
        configureChartData() /* 570 */
        print("Debug : coin is \(self.coinName)") /* 570 */
    }
    
    func configureChartData(){ /* 570 */
        guard let priceData = coin.sparklineIn7D?.price else {return} /* 570 */
        var index = 0.0 /* 570 */
        // need to formatt date from "2022-12-15T00:08:59.307Z" in extension
        self.endDate = Date(coinGeckoString: coin.lastUpdated ?? "") /* 570 */
        // to go back seven days in time /* 570 */
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24) /* 570 */
        
        self.minPrice = priceData.min()! /* 570 */
        self.maxPrice = priceData.max()! /* 570 */
        
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice] /* 570 */
        self.xAxisValues = [startDate, endDate] /* 570 */
        
        for price in priceData.reversed(){ /* 570 */

            let date = endDate.addingTimeInterval(-1 * 60 * 60 * index) // to go hours back in time /* 570 */
            // first pair of data woud be [lastUpdated, price] /* 570 */
            
            let chartDataItem = ChartData(date: date, value: price) /* 570 */
            self.charData.append(chartDataItem) /* 570 */
            index += 1 /* 570 */
        }
    }
    
}
