//
//  TopMoversView.swift
//  swiftCoin
//
//  Created by Johel Zarco on 28/11/22.
//

import SwiftUI

struct TopMoversView: View { /* 573 */
    @StateObject var viewModel : HomeViewModel /* 573 */

    var body: some View { /* 573 */
        VStack(alignment: .leading){ /* 573 */
            Text("Top Movers") /* 573 */
                .font(.headline) /* 573 */
            ScrollView(.horizontal){ /* 573 */
                HStack(spacing : 16){ /* 573 */
                    ForEach(viewModel.topMovingCoins){ coin in /* 573 */
                        NavigationLink { /* 573 */
//                            CoinDetailsView(coin: coin)
                            LazyNavigationView(CoinDetailsView(coin: coin)) /* 573 */
                        } label: { /* 573 */
                            TopMoversItemView(coin: coin) /* 573 */
                        }

                    } //forEach
                } //HStack
            } //ScrollView
        } // VStack
        .padding() /* 573 */
    } // someView
}

//struct TopMoversView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopMoversView()
//    }
//}
