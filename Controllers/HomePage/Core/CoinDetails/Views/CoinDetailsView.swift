//
//  CoinDetailsView.swift
//  swiftCoin
//
//  Created by Johel Zarco on 09/12/22.
//

import SwiftUI

struct CoinDetailsView: View { /* 567 */
    let coin : Coin /* 567 */
    let viewModel : CoinDetailsViewModel  // class level property /* 567 */
    
    init(coin: Coin) { /* 567 */
        self.coin = coin /* 567 */
        self.viewModel = CoinDetailsViewModel(coin: coin) /* 567 */
    }
    
    var body: some View { /* 567 */
            ScrollView(showsIndicators: false){ // to hide scrollV side lines /* 567 */
                // chart
                ChartView(viewModel: viewModel) /* 567 */
                    .frame(height: 250) /* 567 */
                    .padding(.vertical) /* 567 */
                    .shadow(color: viewModel.chartLineColor , radius: 10) /* 567 */
                // overview
                CoinDetailsSection(model: viewModel.overviewSectionModel) /* 567 */
                    .padding(.vertical) /* 567 */
                // additional details
                CoinDetailsSection(model: viewModel.additionalDetailsSectionModel) /* 567 */
                    .padding(.vertical) /* 567 */
            } // scroll
            .padding() /* 567 */
            .navigationTitle(coin.name) /* 567 */
    } // someV
}

//struct CoinDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinDetailsView()
//    }
//}
