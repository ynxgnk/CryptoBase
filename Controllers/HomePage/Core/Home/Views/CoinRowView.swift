//
//  CoinRowView.swift
//  swiftCoin
//
//  Created by Johel Zarco on 29/11/22.
//

import SwiftUI
import Kingfisher /* 576 */

struct CoinRowView: View { /* 576 */
    let coin : Coin /* 576 */
    
    var body: some View { /* 576 */
        HStack{ /* 576 */
            // market cap rank
            Text("\(coin.marketCapRank)") /* 576 */
                .font(.caption) /* 576 */
                .foregroundColor(.gray) /* 576 */
            // image
//            Image(systemName: "bitcoinsign.circle.fill")
            KFImage(URL(string: coin.image)) /* 576 */
                .resizable() /* 576 */
                .scaledToFit() /* 576 */
                .frame(width: 32, height: 32) /* 576 */
                .foregroundColor(.orange) /* 576 */
            // coin name info
            VStack(alignment: .leading, spacing: 4){ /* 576 */
                Text(coin.name) /* 576 */
                    .font(.subheadline) /* 576 */
                    .fontWeight(.semibold) /* 576 */
                    .padding(.leading, 4) /* 576 */
                Text(coin.symbol.uppercased()) /* 576 */
                    .font(.caption) /* 576 */
                    .padding(.leading, 6) /* 576 */
            }
//            .foregroundColor(Color("PrimaryTextColor")) // from color asset to override default blue from navLink
            .foregroundColor(Color.theme.primaryColor) // the color extension we created /* 576 */
            .padding(.leading, 2) /* 576 */
            Spacer() /* 576 */
            // coin price
            VStack(alignment: .trailing, spacing: 4){ /* 576 */
                Text(coin.currentPrice.toCurrency()) /* 576 */
                    .font(.subheadline) /* 576 */
                    .fontWeight(.semibold) /* 576 */
                    .padding(.leading, 4) /* 576 */
                    .foregroundColor(Color.theme.primaryColor) /* 576 */
                
                Text(coin.priceChangePercentage24H.toPercentageString()) /* 576 */
                    .font(.caption) /* 576 */
                    .padding(.leading, 6) /* 576 */
                    .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .pink) /* 576 */
            }
        } // HS
        .padding(.horizontal) /* 576 */
        .padding(.vertical, 4) /* 576 */
    } // someV
} // V

//struct CoinRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinRowView()
//    }
//}
