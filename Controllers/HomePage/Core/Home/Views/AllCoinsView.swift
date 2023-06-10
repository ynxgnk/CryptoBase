//
//  AllCoinsView.swift
//  swiftCoin
//
//  Created by Johel Zarco on 29/11/22.
//

import SwiftUI

struct AllCoinsView: View { /* 575 */
    // in order to receive changes from published, already init'd no need do it again
    @StateObject var viewModel : HomeViewModel /* 575 */
    
    var body: some View { /* 575 */
        VStack(alignment: .leading){ /* 575 */
            Text("All Coins") /* 575 */
                .font(.headline) /* 575 */
                .padding() /* 575 */
            HStack{ /* 575 */
                Text("Coin") /* 575 */
                Spacer()// to move elements to edges
                Text("Price") /* 575 */
                
            }.font(.caption)// apply to entire HStack
                .foregroundColor(.gray) /* 575 */
                .padding(.horizontal) /* 575 */
            
            ScrollView{ /* 575 */
                VStack{ /* 575 */
                    ForEach(viewModel.coins){ coin in /* 575 */
                        NavigationLink { /* 575 */
                            // to avoid pre loading details view until tapped
                            LazyNavigationView(CoinDetailsView(coin: coin)) /* 575 */
//                            CoinDetailsView(coin: coin)
                        } label: { /* 575 */
                            CoinRowView(coin: coin) /* 575 */
                        }

                    }
                }
            } // scrollView
        } // VStack
    } // someVeiw
} // View

//struct AllCoinsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCoinsView()
//    }
//}
