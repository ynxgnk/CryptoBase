//
//  Date.swift
//  swiftCoin
//
//  Created by Johel Zarco on 14/12/22.
//

import Foundation

extension Date{
    // "2022-12-15T00:08:59.307Z"
    init(coinGeckoString : String){ /* 566 */
        let formatter = DateFormatter() /* 566 */
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // from data example above /* 566 */
        let date = formatter.date(from: coinGeckoString) ?? Date() // needs a default value /* 566 */
        self.init(timeInterval: 0, since: date) /* 566 */
    }
    
    // date formatter for chartView
    private var shortDateFormatter : DateFormatter{ /* 566 */
        let formatter = DateFormatter() /* 566 */
        formatter.dateFormat = "MM/dd" /* 566 */
        return formatter /* 566 */
    }
    
    func asShortDateString()-> String{ /* 566 */
        return shortDateFormatter.string(from: self) /* 566 */
    }
    
}
