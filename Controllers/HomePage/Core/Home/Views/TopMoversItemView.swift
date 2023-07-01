//
//  TopMoversItemView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 28/11/22.
//

import SwiftUI
import Kingfisher /* 574 */

struct TopMoversItemView: View { /* 574 */
    let coin : Coin /* 574 */
    
    var body: some View { /* 574 */
        VStack(alignment: .leading, spacing: 2){ /* 574 */
            // image
//            Image(systemName: "bitcoinsign.circle.fill")
            KFImage(URL(string: coin.image)) /* 574 */
                .resizable() /* 574 */
                .frame(width: 32, height: 32) /* 574 */
                .foregroundColor(.orange) /* 574 */
                .padding(.bottom, 8) /* 574 */
            // coin info
            HStack(spacing: 4){ /* 574 */
                Text(coin.symbol.uppercased()) /* 574 */
                    .font(.caption) /* 574 */
                    .fontWeight(.bold) /* 574 */
                    .foregroundColor(Color.theme.primaryColor) /* 574 */
                Text(coin.currentPrice.toCurrency()) /* 574 */
                    .font(.caption) /* 574 */
                    .foregroundColor(.gray) /* 574 */
                
            }
            // coin percent change
            Text(coin.priceChangePercentage24H.toPercentageString()) /* 574 */
                .font(.title) /* 574 */
                .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red) /* 574 */
        } // VS
        .frame(width: 140, height: 140) /* 574 */
        .background(Color.theme.itemBackgroundColor) /* 574 */
        .overlay { /* 574 */
            RoundedRectangle(cornerRadius: 10) /* 574 */
                .stroke(Color(.systemGray4), lineWidth: 2) /* 574 */
        }
    }
}

//struct TopMoversItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopMoversItemView()
//    }
//}
