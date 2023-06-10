//
//  CoinDetailsSection.swift
//  swiftCoin
//
//  Created by Johel Zarco on 12/12/22.
//

import SwiftUI

struct CoinDetailsSection: View { /* 568 */
    
    let model : CoinDetailsSectionModel /* 568 */
    // using grid! 2x2
    private let columns : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())] /* 568 */
    
    
    var body: some View { /* 568 */
        VStack{ /* 568 */
            Text(model.title) /* 568 */
                .font(.title).bold() /* 568 */
                .frame(maxWidth: .infinity, alignment: .leading) /* 568 */
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20){ /* 568 */
                ForEach(model.stats){ stat in /* 568 */
                    StatisticView(model : stat) /* 568 */
                }
            }
        }
    }
}

//struct CoinDetailsSection_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinDetailsSection()
//    }
//}
