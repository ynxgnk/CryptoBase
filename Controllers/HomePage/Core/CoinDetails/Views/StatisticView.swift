//
//  StatisticView.swift
//  swiftCoin
//
//  Created by Johel Zarco on 12/12/22.
//

import SwiftUI

struct StatisticView: View { /* 569 */
    // reusable element coin with statistics data
    let model : StatiscticModel /* 569 */
    
    var body: some View { /* 569 */
        VStack(alignment: .leading, spacing: 4){ /* 569 */
            Text(model.title) /* 569 */
                .font(.caption) /* 569 */
            
            Text(model.value) /* 569 */
                .font(.headline) /* 569 */
            
            if let percentChange = model.percentageChange{ /* 569 */
                HStack(spacing: 4){ /* 569 */
                    Image(systemName: "triangle.fill") /* 569 */
                        .font(.caption) /* 569 */
                    
                    Text(percentChange.toPercentageString()) /* 569 */
                        .font(.caption) /* 569 */
                        .bold() /* 569 */
                } // HS
                .foregroundColor(.green) /* 569 */
            } // ifLet
        } // VS
    } // someV
}

//struct StatisticView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatisticView()
//    }
//}
