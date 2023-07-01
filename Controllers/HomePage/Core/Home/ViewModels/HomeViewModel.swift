//
//  HomeViewModel.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 01/12/22.
//

import Foundation
import SwiftUI

class HomeViewModel : ObservableObject{ /* 571 */
    
    @Published var coins = [Coin]() /* 571 */
    @Published var topMovingCoins = [Coin]() /* 571 */
    @Published var isLoadingData = true /* 571 */
    
    init(){ /* 571 */
        fetchCoinData() /* 571 */
    }
     
    func fetchCoinData(){ /* 571 */
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=24h" /* 571 */
        
        guard let url = URL(string: urlString) else { return } /* 571 */
        URLSession.shared.dataTask(with: url){ data, response, error in /* 571 */
            if let error = error{ /* 571 */
                print("DEBUG: Error \(error.localizedDescription)") /* 571 */
                self.isLoadingData = false /* 571 */
                return /* 571 */
            }
            if let response = response as? HTTPURLResponse{ /* 571 */
                print("DEBUG : \(response.statusCode)") /* 571 */
            }
            guard let data = data else { return } /* 571 */
            print("DEBUG : Data \(data)") /* 571 */
//            let dataAsString = String(data: data, encoding: .utf8)
//            print("DEBUG : \(dataAsString!)")
            
            do{ /* 571 */
                let coins = try JSONDecoder().decode([Coin].self, from: data) /* 571 */
//                print("Debug: lastUpated: \(coins.first?.lastUpdated)")
//                print("Debu: sparkline \(coins.first?.sparklineIn7D)")
                DispatchQueue.main.async { /* 571 */
                    self.coins = coins /* 571 */
                    self.configureTopMovingCoins() /* 571 */
                    self.isLoadingData = false /* 571 */
                }
            }
            catch let error{ /* 571 */
                print("DEBUG: Failed to decode with error: \(error)") /* 571 */
                self.isLoadingData = false /* 571 */
            }
        } // urlss
        .resume() /* 571 */
    } // fetch
    
    func configureTopMovingCoins(){ /* 571 */
        // array or five most variable coins %
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H}) /* 571 */
        self.topMovingCoins = Array(topMovers.prefix(5)) /* 571 */
    }
    
}
